Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130336AbRCBGGM>; Fri, 2 Mar 2001 01:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130341AbRCBGGB>; Fri, 2 Mar 2001 01:06:01 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:45765 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S130336AbRCBGFn>; Fri, 2 Mar 2001 01:05:43 -0500
Date: Fri, 02 Mar 2001 15:05:32 +0900
Message-ID: <snkwhfir.wl@frostrubin.open.nm.fujitsu.co.jp>
From: tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
To: rml@ufl.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2ac8 lost char devices
In-Reply-To: <983511748.3a9f32c4e5ca2@webmail.ufl.edu>
In-Reply-To: <983511748.3a9f32c4e5ca2@webmail.ufl.edu>
User-Agent: Wanderlust/2.4.0 (Rio) EMY/1.13.9 (Art is long, life is short) SLIM/1.14.3 () APEL/10.2 MULE XEmacs/21.2 (beta38) (Peisino) (i386-kondara-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, 

At Fri, 02 Mar 2001 00:42:28 -0500,
<rml@ufl.edu> wrote:
> 
> actually, its not just ps/2 mice -- it seems to be something generic to char
> devices. agpgartis failing to register itself, too.
> 
> what changed with char device handling from ac7 to ac8?
> 
> robert love
> rml@ufl.edu
> -

  misc_register() in drivers/char/misc.c seems to have a problem.


 int misc_register(struct miscdevice * misc)
 {      
        static devfs_handle_t devfs_handle;
-               
+       struct miscdevice *c;
+               
        if (misc->next || misc->prev)
                return -EBUSY;
        down(&misc_sem);
+       c = misc_list.next;
+               
+       while ((c != &misc_list) && (c->minor != misc->minor))
+               c = c->next;
+       if (c == &misc_list) {

  This should be  (c != &misc_list)

+               up(&misc_sem);
+               return -EBUSY;
+       }


---
Nobuhiro Tachino
Development Department
Linux Division
Software Group
FUJITSU LIMITED
TEL: +81 559 24 7273
FAX: +81 559 24 6196
E-Mail: tachino@open.nm.fujitsu.co.jp
