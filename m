Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSCATJM>; Fri, 1 Mar 2002 14:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293633AbSCATIP>; Fri, 1 Mar 2002 14:08:15 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:35856 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S293625AbSCATHG>; Fri, 1 Mar 2002 14:07:06 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76CB@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Roman Kurakin'" <rik@cronyx.ru>
Cc: linux-kernel@vger.kernel.org, "'Russell King'" <rmk@arm.linux.org.uk>
Subject: RE: Serial.c BUG 2.4.x-2.5x
Date: Fri, 1 Mar 2002 11:07:03 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 4:19 AM, Roman Kurakin wrote:
> 
>     Who is responsible person for applying [serial driver] patches 
>     to main tree?

Hi Roman,

Well it's a little complicated. Russell King is the official serial driver
maintainer, at least for 2.5. He is very busy right now on a rewrite of the
serial driver subsystem that will eventually make things better in many ways
for writing support for new devices with serial nature. 

He has (properly) backed away from trying to also support the existing
driver. There has been no willing victim to take on maintainer duties for
the existing driver since Ted Tso got busy with other things over a year
ago. 

BTW, your patch is correct and, as you suspected, there are indeed other
ways that the existing driver is broken for memory mapped devices. My
favorite is the bug that causes kudzu to die with a null pointer dereference
during system initialization IFF there is a memory mapped serial card
present. 

I have been trying to volunteer to ride the current driver into its sunset,
so as to (1) get my own changes in :-), and (2) call for the ignored patches
and help fix the known broken bits (be it known that since 2.4 is a "stable"
release, there are good ideas/enhancements that we simply should not do in
2.4) - without distracting Russell from his good work. The last word I
received was:

> The more help the better as always - providing you can co-ordinate
> with Russell. 

I then asked Russell to set the rules for this co-ordination and no response
has been forthcoming. Perhaps he missed my question? So there is almost, but
not quite, somebody official to evaluate changes to the existing driver and
push the verified patches to Marcelo. I don't think it is time to abandon
the existing driver, just yet. 

BTW, I monitor the abandoned linux-serial mailing list. If you post ignored
patches there I will be more likely to see them than on lkml. If and when
the people in charge say "go", I will start grinding on the existing serial
driver. 

Best regards,
Ed Vance

---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

-----Original Message-----
From: Roman Kurakin [mailto:rik@cronyx.ru]
Sent: Friday, March 01, 2002 4:19 AM
To: linux-kernel@vger.kernel.org
Subject: Serial.c BUG 2.4.x-2.5x


Hi,

    Who is responsible person for applying patches to main tree?

This time I decide to send 2.5.5 patch version:

--- serial-255.c    Thu Feb 28 19:24:47 2002
+++ ../serial-255.c    Wed Feb 20 05:10:59 2002
@@ -2084,7 +2084,6 @@
     unsigned int        i,change_irq,change_port;
     int             retval = 0;
     unsigned long        new_port;
-    unsigned long        new_mem;
 
     if (copy_from_user(&new_serial,new_info,sizeof(new_serial)))
         return -EFAULT;
@@ -2094,7 +2093,6 @@
     new_port = new_serial.port;
     if (HIGH_BITS_OFFSET)
         new_port += (unsigned long) new_serial.port_high << 
HIGH_BITS_OFFSET;
-    new_mem = new_serial.iomem_base;
 
     change_irq = new_serial.irq != state->irq;
     change_port = (new_port != ((int) state->port)) ||
@@ -2136,7 +2134,6 @@
         for (i = 0 ; i < NR_PORTS; i++)
             if ((state != &rs_table[i]) &&
                 (rs_table[i].port == new_port) &&
-                (rs_table[i].iomem_base == new_mem) &&
                 rs_table[i].type)
                 return -EADDRINUSE;
     }

-------- Original Message --------
 Subject: Serial.c Bug
 Date: Wed, 14 Nov 2001 13:02:47 +0300
 From: Roman Kurakin <rik@cronyx.ru>
 To: linux-kernel@vger.kernel.org

   I have found a bug. It is in support of serial cards which uses 
memory for
   I/O insted of ports. I made a patch for serial.c and fix one place, but
   probably the problem like this one could be somewhere else.
  
   If you try to use setserial with such cards you will get "Address in use"
   (-EADDRINUSE)
     
   Best regards,
                    Kurakin Roman


Best regards,
                        Roman Kurakin




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
