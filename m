Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264946AbSKNQVa>; Thu, 14 Nov 2002 11:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbSKNQVa>; Thu, 14 Nov 2002 11:21:30 -0500
Received: from home.deeptown.org ([205.150.192.50]:4994 "HELO deeptown.org")
	by vger.kernel.org with SMTP id <S264946AbSKNQV3> convert rfc822-to-8bit;
	Thu, 14 Nov 2002 11:21:29 -0500
Message-ID: <010401c28bfa$d805d160$34c096cd@toybox>
From: "Serge Kuznetsov" <sk@deeptown.org>
To: <linux-kernel@vger.kernel.org>
Subject: [procfs] Questions regarding proc_mkdir, proc_create, and possible bugs there.
Date: Thu, 14 Nov 2002 11:28:19 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I've got a headache when I trying to understand why it's a common practice to use calls for proc_mkdir, like that:

proc_mkdir ( "drivers/superdriver", 0 ); ?

In proc_mkdir it unwraps to 

 ent = proc_create ( &0, &"drivers/superdriver", (S_IFDIR | S_IRUGO | S_IXUGO),2);

and in proc_create it works like:

 /* skip some code */

        if (!(*(&0)) && xlate_proc_name(name, &0, &fn) != 0)                         
                goto out;                                                                  

/* skip the rest */
 
I can understand what by address 0x00000000 ( in kernel space ) it suppose to be some value ( GIDT[0] if I am not wrong ), but it's quite dangerous to use this practice.

Correct me if I am wrong.

PS: In xlate_proc_entry parent is not being checks for NULL but just stores the result, and it can happen SEGFAULT there. 

PPS: BTW, I tested my module, and maid insmod/rmmod every time, I found when module_init called mkdir_every time I do insmod, in /proc dir created the new duplicate subdir with absolutely the same name, and it grows when I do insmod/rmmod but forget to call remove_proc_entry. I think the issue in xlate_proc_name and NULL pointer.

PPPS: Now I am testing the patch for it.


All the Best!
Serge.
