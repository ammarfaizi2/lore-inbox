Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVETV2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVETV2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 17:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVETV2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 17:28:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60102 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261594AbVETV2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 17:28:01 -0400
Date: Fri, 20 May 2005 22:28:24 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Neil Horman <nhorman@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] vfs: increase scope of critical locked path in fget_light to avoid race
Message-ID: <20050520212824.GS29811@parcelfarce.linux.theplanet.co.uk>
References: <20050520132325.GE19229@hmsendeavour.rdu.redhat.com> <20050520133337.GP29811@parcelfarce.linux.theplanet.co.uk> <20050520134046.GQ29811@parcelfarce.linux.theplanet.co.uk> <20050520152550.GF19229@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050520152550.GF19229@hmsendeavour.rdu.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 11:25:50AM -0400, Neil Horman wrote:
> I don't have the complete race scenario, just a stack that suggests that
> files->fd was corrupted.  This problem isn't recreatable at will (yet), so this
> is really based on a thought experiment more than anything else.  The conditions
> that I was envisioning was a multithreaded application in which two threads
> modified  the same file descriptor at the same time.  Its my understanding, from
> the way I read the code that the ref count on a file_struct will still be one
> for a multithreaded application, and as such it would be possible, using the
> fget_light routine for one thread to be be preforming an operation on an
> descriptor in the fd array, while another thread preformed another operation

Incorrect.  References to files_struct are held by task_struct.  Kernel
stack is determined by task_struct.  So your two threads would have
to share task_struct (i.e. be purely userland ones) and could not
run in the kernel at the same time for very obvious reasons.

The rules are simple:
	* all access to files_struct is done from upper-half (i.e. is
process-synchronous).
	* the only files_struct you can modify is *(current->files)
	* each task_struct that has ->files pointing to given files_struct
contributes 1 to ->count of that files_struct.  There might be other holders
of temporary references and they also contribute to ->count.
	* all changes of task->files itself are process-synchronous.  Only
two kinds of changes are possible:
	1) current->files can be set to NULL.  That drops a reference to
original files_struct.
	2) current->files can be replaced with a pointer to a new copy of
previous files_struct.  This operations drops a reference to old one and
sets the refcount on a copy to 1.  It could either be done explicitly (when
unshare(2) gets merged into Linus' tree) or implicitly at the clone()/fork()
time.  In the latter case that's done by parent to child before the child
gets a chance to run.
	* at task creation time, child inherits ->files from parent; that
acquires a new reference to it.  That might be followed by implicit unshare()
(see above).  fork(2) always unshares ->files, clone(2) does that unless
CLONE_FILES had been passed to it in flags.

IOW, the only way for two tasks to have ->files pointing to the same object
is to have it unchanged all the way back to common ancestor.  In particular,
if current->files->count is 1, we know that no other task has ->files pointing
to our files_struct and that will remain true until we call clone().  It does
*not* mean that current->files->count will remain 1; somebody might acquire
a temporary reference to our files_struct.  However, we are guaranteed that
all such references will be used only for read-only access (that happens,
e.g., when somebody does ls /proc/<our_pid>/fd - they will grab a reference
to our ->files and go looking at the descriptor table; they are not allowed
to change it, though).
