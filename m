Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263703AbRF1TD4>; Thu, 28 Jun 2001 15:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263746AbRF1TDq>; Thu, 28 Jun 2001 15:03:46 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:42966 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S263703AbRF1TDm>; Thu, 28 Jun 2001 15:03:42 -0400
Importance: Normal
Subject: Re: [PATCH] Bug in 2.4.5 in proc_pid_make_inode ()
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Gerhard Wichert <Gerhard.Wichert@fujitsu-siemens.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF2F8AF5FE.1F3D1D3A-ONC1256A79.0067C5E1@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Thu, 28 Jun 2001 21:03:08 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.6 |December 14, 2000) at
 28/06/2001 21:03:12
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck wrote:

>I have recently experienced a number of kernel OOPSes
>in "top" under heavy load. Kernel is 2.4.5 (IA64, but
>this has nothing to do the IA64 patch).

Same here; I just debugged these on S/390 ...

>I have seen 2.4.6-pre6 contains changes to this subroutine as well,
>but they seem to be attacking a different problem.
>Having analyzed the stack trace and the kernel code with objdump,
>I am pretty certain that the changes in 2.4.6-pre6 do not fix my problem
>(if they did, I would see a crash in proc_pid_delete_inode rather
>than in proc_delete_inode).

I think the -pre6 code should be OK.  Note that the crash in
proc_delete_inode() occurs because the pointer to the parent
proc_dir_entry (which is taken from inode->u.generic_ip) is
non-zero.

In 2.4.5, this is the case because proc_pid_make_inode
assigns a value to inode->u.proc_i.task before calling iput().
That field overlays inode->u.generic_ip ...

In the 2.4.6-pre patches, the test for a zero pid is moved to
*before* assigning to inode->u.proc_i.task.  Therefore, when
iput calls proc_delete_inode(), the 'de' pointer will be
zero, and nothing will happen.

Whether this is particularly pretty is debateable, but it
appears to be correct.


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com


