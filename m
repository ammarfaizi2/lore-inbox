Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbUCJVW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbUCJVWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:22:55 -0500
Received: from fungus.teststation.com ([212.32.186.211]:56840 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S262848AbUCJVWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:22:46 -0500
Date: Wed, 10 Mar 2004 22:22:16 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Adam Sampson <azz@us-lot.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: smbfs Oops with Linux 2.6.3
In-Reply-To: <Pine.LNX.4.58.0403101359150.29087@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.44.0403102145460.12892-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Zwane Mwaikambo wrote:

> On Wed, 10 Mar 2004, Zwane Mwaikambo wrote:
> 
> > Thanks Urban, i have posted the following on bugzilla
> > (http://bugzilla.kernel.org/show_bug.cgi?id=1671) for testing. But,
> > it appears racy wrt getattr and win9x servers.

The 5 second timeout is probably too short. Some bad configs can use a 
long time to connect, possibly more. 30?


> How about the following to synchronize with smb_newconn()
> 
> smb_lock_server(server);
> smb_unlock_server(server);

Shouldn't "wq" be accessible to both smb_newconn and smb_proc_ops_wait?
I'd put it in the "server" struct and then have smb_newconn() do this 
when it is done:
	wake_up_interruptible_all(&server->ops_wq);

I don't know enough about wait_queue's to understand why it would work
otherwise. The only thing I can think of is that the condition is true
before it actually waits on anything.

Since install_ops isn't the last thing done in smb_newconn perhaps a
different variable should be used to signal that a new connection is
there. I would suggest using "server->state == CONN_VALID" and then move
that assignment to the end of smb_newconn.


I'm guessing read/write/truncate can't be called before smb_newconn since
they all require a file to be opened, and open needs getattr (or?). But
just to be safe how about adding the code below?

static int
smb_proc_ops_bug(void)
{
	BUG();
}

static struct smb_ops smb_ops_null =
{
	.readdir	= smb_proc_readdir_null,
	.getattr	= smb_proc_getattr_null,
	.read		= (void *) smb_proc_ops_bug,
	.write		= (void *) smb_proc_ops_bug,
	.truncate	= (void *) smb_proc_ops_bug,
};

If the void* can be avoided by something clever then that is what I really 
meant :)


> I've already uploaded the new patch on Bugzilla, but i also came across a
> smb_dir_cache related oops whilst testing, which i'm debugging.

If you are in cleanup mode the following changes should probably be made:

server->rcls	replaced by	req->rq_rcls
server->err	replaced by	req->rq_err

and remove the server->{rcls,err} fields.

/Urban

