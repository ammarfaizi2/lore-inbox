Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268617AbTGIW1L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268620AbTGIW1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:27:11 -0400
Received: from fmr03.intel.com ([143.183.121.5]:25283 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S268617AbTGIW1F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:27:05 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Redundant memset in AIO read_events
Date: Wed, 9 Jul 2003 15:41:39 -0700
Message-ID: <41F331DBE1178346A6F30D7CF124B24B2A488B@fmsmsx409.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Redundant memset in AIO read_events
Thread-Index: AcNGGVSaV3ScAPC3RhOjUTdpOpJtyQAH+BVg
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
X-OriginalArrivalTime: 09 Jul 2003 22:41:40.0097 (UTC) FILETIME=[434B7710:01C3466B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK, here is another one.  In the top level read_events() function in
>> fs/aio.c, a struct io_event is instantiated on the stack (variable
ent).
>> It calls aio_read_evt() function which will fill the entire io_event
>> structure into variable ent.  What's the point of zeroing when copy
>> covers the same memory area?  Possible a debug code left around?
>
>Read the comment before that memset. The structure might contain some
>padding (bytes not belonging to any of its entries), these bytes are
>random and if you do not zero them, you copy random data into
userspace.
>
>Mikulas

Please have the courtesy of reading the relevant aio code in the entire
context.  The comment doesn't make any sense for the current state of
the code.  My guess is that it is left from stone age.

read_events(...) {
   struct io_event ent;
   memset(&ent, 0, sizeof(ent));
   while (...) {
      aio_read_evt(ctx, &ent);
   }
   ...
}

read_events calls aio_read_evt and passes pointer to ent as argument.

aio_read_evt(..., struct io_event *ent) {
  ...
  *ent = *evp;
  ...
}

Where on earth is the padding with respect to memset and struct copying?

If you are still not convinced and having doubts in understanding the C
code, then look at the assembly:

In read_events():
     e64:       31 c0                   xor    %eax,%eax
     ....
     e98:       b9 08 00 00 00          mov    $0x8,%ecx
     e9d:       f3 ab                   repz stos %eax,%es:(%edi)
<- 32 byte memset ->

In aio_read_evt()
     ddf:       8b 34 24                mov    (%esp,1),%esi
     de2:       b9 08 00 00 00          mov    $0x8,%ecx
     de7:       f3 a5                   repz movsl %ds:(%esi),%es:(%edi)
<- 32 byte structure copying ->

Now tell me again where on earth it has anything to do with padding?  If
there is any padding going on, it is overridden by the source of the
structure copying, effectively nullify the attempt of memset.

- Ken
