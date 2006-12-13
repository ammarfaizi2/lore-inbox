Return-Path: <linux-kernel-owner+w=401wt.eu-S964799AbWLMOaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWLMOaP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 09:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWLMOaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 09:30:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:4069 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964799AbWLMOaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 09:30:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t9VqoC/7FmqLwXFzHEwuHNyZl2DP6ErH6OiqtLt2ksbRXUoCpmacEvM2G9+W374+ybYXd3Q+NB7FJN3o9sVpCDVDybP9XUUKk4wMQsqwkbz4KKzvBLhPfhmTjQL40R8fSr7JH86YHHx0gMsHftc87wXl1cirpxPtnD+yhYW1HVU=
Message-ID: <e6babb600612130630y341aaadehb0436ade65ea6f7d@mail.gmail.com>
Date: Wed, 13 Dec 2006 07:30:12 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Keith Curtis" <Keith.Curtis@digeo.com>
Subject: Re: isochronous receives?
Cc: linux1394-devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <DD2010E58E069B40886650EE617FCC0CBA8EC9@digeo-mail1.digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <AccTUZEOi7v6J84+R+eLGKj8lA2txQAz+0pA>
	 <DD2010E58E069B40886650EE617FCC0CBA8EC9@digeo-mail1.digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/06, Keith Curtis <Keith.Curtis@digeo.com> wrote:
> I never resolved the problem. I turned on the excessive debugging output, but it
> didn't print out info about receiving packets or interrupts. My test
> app claimed there were no packets received although the bus analyzer
> showed lots of packets going by.

Well, I figured it out, finally.  Thankfully (in a way...), it was my
code: I was setting the tag to -1 in a certain spot (which indicates
that you want to see all packets, regardless of their tag), but
unhelpfully changing it to 0 before calling raw1394_iso_recv_start...

...dangit, though.  Looking at the data stream, the tag *is* zero.

Stefan, isn't the line:

        /* match on specified tags */
        contextMatch = tag_mask << 28;

in ohci_iso_recv_start() wrong?  The register looks to work like this.
 The tag field is two bits.

if you want to match on 11b, then set bit tag3 (bit 31)
if you want to match on 10b, then set bit tag2 (bit 30)
if you want to match on 01b, then set bit tag1 (bit 29)
if you want to match on 00b, then set bit tag0 (bit 28)

Which makes the shift obviously wrong.  Passing in '3' to match on tag
11b will have you instead set bits 29 and 28, and you will match on
01b and 00b.  Passing in '0' will completely bone you: no bits will be
turned on.  Passing in '-1' to match all bits does work, though.
You'd have to know to pass in 0x8 to match for tag 11b, which is a
skosh counterintuitive and probably not what was intended.

Here's my crap patch.  It appears to Work For Me(tm).

--- ohci1394.c  2006-12-04 16:52:10.916044780 -0700
+++ modified_ohci1394.c 2006-12-13 07:22:07.613917511 -0700
@@ -1491,7 +1491,18 @@
        reg_write(recv->ohci, recv->ContextControlSet, command);

        /* match on specified tags */
-       contextMatch = tag_mask << 28;
+        switch (tag_mask)
+        {
+       case -1: contextMatch = tag_mask << 28; break;
+       case 0: contextMatch = (1 << 28); break;
+       case 1: contextMatch = (1 << 29); break;
+       case 2: contextMatch = (1 << 30); break;
+       case 3: contextMatch = (1 << 31); break;
+       default:
+               DBGMSG("Invalid tag_mask %0x, matching all tags",tag_mask);
+               contextMatch = tag_mask << 28;
+               break;
+       }

        if (iso->channel == -1) {
                /* enable multichannel reception */


So nevermind.  I'm totally vindicated and my code is, as always,
flawless.  Cough.

-- 
Robert Crocombe
rcrocomb@gmail.com
