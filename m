Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262376AbRENTB3>; Mon, 14 May 2001 15:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262377AbRENTBS>; Mon, 14 May 2001 15:01:18 -0400
Received: from comverse-in.com ([38.150.222.2]:33742 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S262376AbRENTBK>; Mon, 14 May 2001 15:01:10 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678EC2@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: uid_t and gid_t vs.  __kernel_uid_t and __kernel_gid_t
Date: Mon, 14 May 2001 15:00:18 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="koi8-r"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had to communicate uid/gid from an application down 
to a driver, and discovered that uid and gid in user
space are different from those in kernel space.

I am porting both the driver and the app from platforms
where uid and gid in userland don't differ from their
counterparts down in the kernel.

What would be the appealing portable way (across all 
Linux platforms with their different byteorders) to 
declare a type for such user/kernel interface?

Right now I am using smth that I feel is ugly a bit, 
to declare fields of a transparent type:
/* MY uid_t/gid_t - shared types for user and kernel space */ 
   #if defined(LINUX) && defined (__KERNEL__) 
    
   #ifdef CONFIG_X86 
    
   #       define my_uid_t(var_name,pad_name) \ 
                   __kernel_uid_t var_name; unsigned short pad_name 
   #       define my_gid_t(var_name,pad_name) \ 
                   __kernel_gid_t var_name; unsigned short pad_name 
   #else /* other archs I need to support, with arch-specific alignment */
...
   #endif 
    
   #else /* Not Linux kernel - uid/gid same in user/kernel space */ 
   #       define my_uid_t(var_name,pad_name) uid_t var_name 
   #       define my_gid_t(var_name,pad_name) gid_t var_name 
   #endif 

and also I need special functions to set/get the var+
padding in kernel to make sure that the padding is set 
to 0/-1 according to the sign of the var, each time I get
smth from/send smth to the userland from the kernel.

Is there a known pattern for doing things like this? 
Maybe some special macros just for gid/uid specifically? I am 
just feeling that I try reinvent a wheel here...

Kind regards,
	Vassilii
