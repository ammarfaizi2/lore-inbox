Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKVLf5>; Wed, 22 Nov 2000 06:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129582AbQKVLfr>; Wed, 22 Nov 2000 06:35:47 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:2553 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S129150AbQKVLfj>;
	Wed, 22 Nov 2000 06:35:39 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20001121160443.B18150@lahmed.stanford.edu> 
In-Reply-To: <20001121160443.B18150@lahmed.stanford.edu>  <Pine.LNX.4.21.0011212328570.30344-100000@svea.tellus> 
To: David Hinds <dhinds@lahmed.stanford.edu>
Cc: Tobias Ringstrom <tori@tellus.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why not PCMCIA built-in and yenta/i82365 as modules 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Nov 2000 11:05:20 +0000
Message-ID: <6911.974891120@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


dhinds@lahmed.stanford.edu said:
>  Is there a technical reason for this?  Not that I know of; but then I
> also cannot think of a good reason for wanting, say, the generic code
> built in but the controller support as modules.  I do see reasonable
> arguments for all-builtin or all-modules.

register_ss_entry() is broken and when you unload a socket driver it'll get 
very confused and leave /proc entries behind. You can clean this up by 
removing pcmcia_core.o and reloading it.

If you have pcmcia_core.o built in and a socket driver as a module, then 
obviously you can't do this without rebooting.

I doubt this was known at the time the Config.in choices were made, but 
it's sufficient reason right now to leave it as it is.

The correct fix is to dump the static socket tables completely, as has
already happened in the standalone code, but I think that should probably
wait for 2.5. In the meantime, this patch ought to work around the problem
for most cases - although it'll still break if you load 2 socket drivers,
then unload them again FIFO.

Index: drivers/pcmcia/cs.c
===================================================================
RCS file: /net/passion/inst/cvs/linux/drivers/pcmcia/Attic/cs.c,v
retrieving revision 1.1.2.28
diff -u -r1.1.2.28 cs.c
--- drivers/pcmcia/cs.c 2000/11/10 14:56:32     1.1.2.28
+++ drivers/pcmcia/cs.c 2000/11/22 10:37:33
@@ -416,12 +416,10 @@
 {
     int i;
 
-    for (i = 0; i < sockets; i++) {
+    for (i = sockets-1; i >= 0; i-- ) {
        socket_info_t *socket = socket_table[i];
        if (socket->ss_entry == ss_entry)
-           pcmcia_unregister_socket (socket);
-       else
-           i++;
+               pcmcia_unregister_socket (socket);
     }
 } /* unregister_ss_entry */
 


--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
