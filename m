Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263366AbTCEGoz>; Wed, 5 Mar 2003 01:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbTCEGoz>; Wed, 5 Mar 2003 01:44:55 -0500
Received: from thunk.org ([140.239.227.29]:34220 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S263366AbTCEGoy>;
	Wed, 5 Mar 2003 01:44:54 -0500
Date: Wed, 5 Mar 2003 01:54:20 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christopher Li <chrisl@vmware.com>
Cc: "'Daniel Phillips'" <phillips@arcor.de>,
       "James H. Cloos Jr." <cloos@jhcloos.com>,
       ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] Re: ext3 htree brelse problems look to be fixed!
Message-ID: <20030305065419.GA22296@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christopher Li <chrisl@vmware.com>,
	'Daniel Phillips' <phillips@arcor.de>,
	"James H. Cloos Jr." <cloos@jhcloos.com>,
	ext2-devel@lists.sourceforge.net, ext3-users@redhat.com,
	linux-kernel@vger.kernel.org
References: <3C77B405ABE6D611A93A00065B3FFBBA36A531@PA-EXCH2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C77B405ABE6D611A93A00065B3FFBBA36A531@PA-EXCH2>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 06:36:54PM -0800, Christopher Li wrote:
> I post a patch for comment on ext2-devel for the
> NFS cookie bug.  Did not get any feedback yet.
> As Ted suggested, it set the cookie to -1 on EOF,
> even though it is not seek able to there.

The patch was almost good enough.  The problem with your simple
version was that on the subsequent call to ext3_dx_readdir, the -1 got
translated to a hash value of fffffffe, and if you were unlucky enough
to have a file whose hash was 0xfffffffe, you'd still end up looping
forever.

See the patch which I just sent to ext2-devel and LKML, which I think
solves both this problem and the conversion-to-htree-while-doing-NFS-readdir 
problem.   What I did was to treated f_pos==-1 as an explicit EOF cookie, 
instead of letting it get translated into large hash value.  I also explicitly 
returned a next_hash value of ~0 when there was no more leaf pages, which 
then got immediately translated into a f_pos value of -1.  This saves an 
extra call to ext3_htree_fill_tree(), a minor optimization.

						- Ted
