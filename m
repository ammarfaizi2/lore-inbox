Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269417AbRIDV5C>; Tue, 4 Sep 2001 17:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269463AbRIDV4x>; Tue, 4 Sep 2001 17:56:53 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:6664 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S269421AbRIDV4n>;
	Tue, 4 Sep 2001 17:56:43 -0400
Date: Tue, 4 Sep 2001 23:56:55 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Kenneth Michael Ashcraft <kash@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] security errors for 2.4.9 and 2.4.9-ac7
Message-ID: <20010904235655.A12348@vana.vc.cvut.cz>
In-Reply-To: <Pine.GSO.4.31.0109041405210.15852-100000@saga18.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.31.0109041405210.15852-100000@saga18.Stanford.EDU>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 02:07:05PM -0700, Kenneth Michael Ashcraft wrote:
> /home/kash/linux/2.4.9/fs/ncpfs/ioctl.c:394:ncp_ioctl: ERROR:RANGE:387:394: Using user length "outl" as argument to "copy_to_user" [type=LOCAL] [state = need_lb] set by 'copy_from_user':387 [linkages -> 387:outl=object_name_len -> 387:user->object_name
> 
> 			if (copy_from_user(&user,
> 					   (struct ncp_objectname_ioctl*)arg,
> 					   sizeof(user))) return -EFAULT;
> 			user.auth_type = server->auth.auth_type;
> Start --->
> 			outl = user.object_name_len;
> 			user.object_name_len = server->auth.object_name_len;
> 			if (outl > user.object_name_len)
> 				outl = user.object_name_len;
> 			if (outl) {
> 				if (copy_to_user(user.object_name,
> 						 server->auth.object_name,
> Error --->
> 						 outl)) return -EFAULT;
> 			}
> 			if (copy_to_user((struct ncp_objectname_ioctl*)arg,
> 					 &user,
> ---------------------------------------------------------
> [BUG] make user.len large enough so that outl becomes negative.  outl will then be < server->priv.len and make it past the check (gem)
> /home/kash/linux/2.4.9/fs/ncpfs/ioctl.c:462:ncp_ioctl: ERROR:RANGE:456:462: Using user length "outl" as argument to "copy_to_user" [type=LOCAL] [state = need_lb] set by 'copy_from_user':456 [linkages -> 456:outl=len -> 456:user->len -> 456:user:start] 

Hi Kenneth,
  I'll fix these two - but fortunately they are no problem even now.
Although outl is defined as 'int', it is compared against
'user.object_name_len', which is 'size_t' (which is unsigned int),
so whole comparsion is done unsigned and not signed. Thanks
for spotting anyway, there is no reason why it should not be
size_t.
					Petr Vandrovec
					vandrove@vc.cvut.cz

P.S.: And report about drivers/video/matrox/matroxfb_crtc2:535
is completely innocent - it passes these three mentioned
ioctl types down to first head's ioctl handler (and it is
not sisfb_ioctl, definitely... usually it is matroxfb_ioctl
from matroxfb_base.c).

