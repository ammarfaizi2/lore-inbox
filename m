Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUB0CX3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 21:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUB0CX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 21:23:29 -0500
Received: from mail-gate.ait.ac.th ([202.183.214.47]:33940 "EHLO
	mail-gate.ait.ac.th") by vger.kernel.org with ESMTP id S261239AbUB0CXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 21:23:15 -0500
Date: Fri, 27 Feb 2004 09:23:11 +0700
From: Alain Fauconnet <alain@ait.ac.th>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smbfs broken in 2.4.25? (Too many open files in system)
Message-ID: <20040227022300.GA8072@ait.ac.th>
References: <20040226110903.GC621@ait.ac.th> <Pine.LNX.4.44.0402262000040.3800-100000@cola.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402262000040.3800-100000@cola.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 08:24:08PM +0100, Urban Widmark wrote:
> On Thu, 26 Feb 2004, Alain Fauconnet wrote:
> 
> > I get random 'Too many open files in system'. E.g.:
> > 
> > # /usr/local/samba/bin/smbmount //w98box/c /dosc -o password=xxxxx
> > # ls /dosc
> > /bin/ls: /dosc: Too many open files in system
> > (command repeated several times: hit up arrow and enter... and then:)
> > # ls /dosc
> > ASD.LOG*       BIN/          CONFIG.TXT*  MSDOS.SYS*       SUHDLOG.---*
> > AUTOEXEC.001*  BOOTLOG.DMA*  CONFIG.W95*  MSDOS.W95*       SUHDLOG.BAK*
> > (...works!)
> 
> The "too many files" part is what smbfs translates the server error into.
> ethereal calls it a "Non specific error code" (ERRSRV/ERRerror).
> 
> The problem here is that for some reason win98 doesn't always handle that 
> a client requests info on the / inode with too short interval. It 
> often understands the request (for me about 14 times out of 15), but 
> sometimes it just fails.
> 
> 
> 2.4.25 has some code that was backported from 2.6, where the "win95" 
> codepath was changed. I need to check that, but it probably doesn't work 
> there either.
> 
> Patch below works for me. It is copied from the smbfs readdir code that 
> happens to have the same problem with win9x.
> (Well, it's the same request so ... :)
>
[patch edited out for brievety, see archives]

Thanks Urban, that did it.

I however  observe  the  following:  when  using  the  patched  2.4.25
module,  a  "ls  /dosc" (where /dosc is the dir I mount the shared C:
drive  of  a  WIN98  box  into)  sometimes shows a noticeable delay. I
suspect it is when the patched code does a retry. E.g.:

# time ls /dosc >/dev/null
0.000u 0.000s 0:00.20 0.0%      0+0k 0+0io 157pf+0w
(noticeable delay)
# time ls /dosc > /dev/null
0.000u 0.010s 0:00.00 0.0%      0+0k 0+0io 157pf+0w
(normal)
# time ls /dosc > /dev/null
0.010u 0.000s 0:00.80 1.2%      0+0k 0+0io 157pf+0w
(even more noticeable delay)

This happens at most 1 time out of 5, so the sample above
doesn't match reality.

If I load the module build from 2.4.24 sources instead:
# umount /dosc
# rmmod smbfs
# insmod ../smbfs.2.4.24/smbfs.o
# /usr/local/samba/bin/smbmount //w98box/c /dosc -o password=xxxxx

this delay goes away:
# time ls /dosc > /dev/null
0.000u 0.000s 0:00.00 0.0%      0+0k 0+0io 157pf+0w
(normal, consistently)

Not  a  big deal probably, and I'm not sure that kernel developers are
that  much motivated to work around bugs in Win9x, but somehow I think
that the 2.4.24 smbfs code didn't trigger this bug at all, whereas the
new  code  does  trigger  it  and  thus  needs  these delayed retries.

Looking   at   the   code   of   both   versions,   it   seems    that
smb_proc_getattr_95()  (where  the  patch  you've  posted  lies)  uses
smb_proc_getattr_trans2_std()  whereas  the   old   code   seemed   to
completely avoid it in the W95 code path:

>From 2.4.24's ./fs/smbfs/proc.c:
========================================================================
        /*
         * Select whether to use core or trans2 getattr.
         * Win 95 appears to break with the trans2 getattr.
         */
        if (server->opt.protocol < SMB_PROTOCOL_LANMAN2 ||
            (server->mnt->flags & (SMB_MOUNT_OLDATTR|SMB_MOUNT_WIN95)) ) {  
                result = smb_proc_getattr_core(server, dir, fattr);
        } else {
                if (server->mnt->flags & SMB_MOUNT_DIRATTR)
                        result = smb_proc_getattr_ff(server, dir, fattr);
                else
                        result = smb_proc_getattr_trans2(server, dir, fattr);
        }
========================================================================

Am I completely off track here?

Greets,
_Alain_
