Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132741AbRDMAck>; Thu, 12 Apr 2001 20:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132816AbRDMAca>; Thu, 12 Apr 2001 20:32:30 -0400
Received: from [216.18.66.100] ([216.18.66.100]:522 "HELO
	jumpgate.inphinity.com") by vger.kernel.org with SMTP
	id <S132741AbRDMAcT>; Thu, 12 Apr 2001 20:32:19 -0400
From: Chad Hogan <Chad.Hogan@inphinity.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Organization: Inphinity Interactive
Subject: system call logging in userspace
Date: Thu, 12 Apr 2001 17:32:07 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0104121732070D.51519@usul.inphinity.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I'm not very experienced with dealing directly with the kernel, so I was 
hoping for a little advice...

I'd like to implement some sort of rudimentary (file)system-call logging.  
Specifically, I'd like information about write, open, creat, unlink, and 
maybe a few others to be pushed into userspace.  Mostly, I'd just like to 
know what files are being created, modified, and deleted as it happens.

It seems quite easy to me -- I was thinking of doing this with a module.  
I'll just grab the pointer from sys_call_table[__NR_open] and replace it with 
my own little wrapper that does nothing but call the original function, and 
then log the call in some manner.

================

asmlinkage int my_sys_open(const char *fname, int flags, int mode)
{
         [preliminary stuff]

         returnval = real_sys_open(fname, flags, mode);

         [log information based on returnval, fname, whatever];

         return returnval;
}


int init_module()
{
         [other stuff]

         real_sys_open = sys_call_table[__NR_open];
         sys_call_table[__NR_open] = my_sys_open;
         return 0;
}

init cleanup_module()
{
         sys_call_table[__NR_open] = real_sys_open;
}

===========

The simplicity of the whole thing is what scares me a little bit.  Am I being 
horribly naive about something here?  It seems like an obviously useful 
module to have around, and yet I've never seen it and I couldn't find anyone 
who had done it already.  Is there a much better way to accomplish this than 
loading in a module?  Am I risking serious fs corruption?

It occurs to me that I may have some problems if something else changes the 
sys_call_table[__NR_open] and the two modules don't cooperate...

Thanks.
- -- 
Chad Hogan                                 chad.hogan@inphinity.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (FreeBSD)
Comment: For info see http://www.gnupg.org

iD8DBQE61kkHiSF5tViVwg0RAkMOAJ4rMTC/xvvknmiSf512Y5d06ezdpgCfZH+s
rEQ6ltXalr2SVqFg7lhIFYc=
=iBPm
-----END PGP SIGNATURE-----
