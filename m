Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263891AbTCUWGG>; Fri, 21 Mar 2003 17:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263896AbTCUWF4>; Fri, 21 Mar 2003 17:05:56 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:61426 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S263891AbTCUWFR>; Fri, 21 Mar 2003 17:05:17 -0500
Date: Fri, 21 Mar 2003 14:15:07 -0800
From: Chris Wright <chris@wirex.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, alan@lxorguk.ukuu.org.uk
Subject: Re: [CHECKER] potential dereference of user pointer errors
Message-ID: <20030321141507.B646@figure1.int.wirex.com>
Mail-Followup-To: Junfeng Yang <yjf@stanford.edu>,
	linux-kernel@vger.kernel.org, mc@cs.stanford.edu,
	alan@lxorguk.ukuu.org.uk
References: <200303041112.h24BCRW22235@csl.stanford.edu> <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU>; from yjf@stanford.edu on Thu, Mar 20, 2003 at 10:33:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Junfeng Yang (yjf@stanford.edu) wrote:
> 
> [BUG] cmd is tainted. then they do copy_to_user (cmd->resbuf, ...) resbuf
> is declared as a pointer, not an array, so cmd->resbuf can point to
> anywhere.
> 
> /home/junfeng/linux-2.5.63/drivers/message/i2o/i2o_config.c:440:ioctl_parms:
> ERROR:TAINTED deferencing "cmd" tainted by [dist=0][(null)]

I don't think this could be used to corrupt kernel data because the
copy_to_user will, of course, still verify the resbuf pointer, and the
original copy_from_user validated the cmd pointer.  The possibility of
trashing the processes own memory space is there, but can be done anyway
on first pass of the cmd.  However, this is inconsistent with the rest
of the file, so here is a patch to use kcmd.resbuf.  I also added a NULL
check, as done in similar funcitons in this file.  Alan, this look ok?

thanks,
-chris
--
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

===== drivers/message/i2o/i2o_config.c 1.14 vs edited =====
--- 1.14/drivers/message/i2o/i2o_config.c	Wed Feb 19 12:18:31 2003
+++ edited/drivers/message/i2o/i2o_config.c	Fri Mar 21 14:17:20 2003
@@ -394,6 +394,9 @@
 	if(get_user(reslen, kcmd.reslen))
 		return -EFAULT;
 
+	if(!kcmd.resbuf)
+		return -EFAULT;
+
 	c = i2o_find_controller(kcmd.iop);
 	if(!c)
 		return -ENXIO;
@@ -437,7 +440,7 @@
 	put_user(len, kcmd.reslen);
 	if(len > reslen)
 		ret = -ENOBUFS;
-	else if(copy_to_user(cmd->resbuf, res, len))
+	else if(copy_to_user(kcmd->resbuf, res, len))
 		ret = -EFAULT;
 
 	kfree(res);
