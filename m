Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315273AbSEDDSu>; Fri, 3 May 2002 23:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315176AbSEDDSu>; Fri, 3 May 2002 23:18:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40832 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315273AbSEDDSs>;
	Fri, 3 May 2002 23:18:48 -0400
Date: Fri, 03 May 2002 20:07:47 -0700 (PDT)
Message-Id: <20020503.200747.104775821.davem@redhat.com>
To: bruce.holzrichter@monster.com
Cc: linux-kernel@vger.kernel.org, ak@muc.de
Subject: Re: my slab cache broken on sparc64
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <61DB42B180EAB34E9D28346C11535A781780F9@nocmail101.ma.tmpw.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
   Date: Fri, 3 May 2002 22:15:56 -0500 

Your patch is buggy:

   +			mm_segment_t old_fs = get_fs();
   +			set_fs(KERNEL_DS);
    			if (__get_user(tmp,pc->name)) { 
    				printk("SLAB: cache with size %d has lost
   its name\n", 
    					pc->objsize); 
    				continue; 
   -			} 	
   +			}
   +			set_fs(old_fs); 	

If the __get_user() fails, you will leave the kernel in the
KERNEL_DS segment.

Do it like this instead.

	int fault;
	mm_segment_t old_fs;

	...

	old_fs = get_fs();
	set_fs(KERNEL_DS);
	fault = __get_user(tmp, pc->name);
	set_fs(old_fs);

	if (fault) {
	...
