Return-Path: <linux-kernel-owner+w=401wt.eu-S965060AbWLMSqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWLMSqJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964926AbWLMSqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:46:09 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:40077 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965060AbWLMSqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:46:07 -0500
X-Greylist: delayed 1112 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 13:46:07 EST
Message-ID: <45804615.3060004@s5r6.in-berlin.de>
Date: Wed, 13 Dec 2006 19:27:33 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Robert Crocombe <rcrocomb@gmail.com>
CC: Keith Curtis <Keith.Curtis@digeo.com>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: isochronous receives?
References: <AccTUZEOi7v6J84+R+eLGKj8lA2txQAz+0pA>	<DD2010E58E069B40886650EE617FCC0CBA8EC9@digeo-mail1.digeo.com> <e6babb600612130630y341aaadehb0436ade65ea6f7d@mail.gmail.com>
In-Reply-To: <e6babb600612130630y341aaadehb0436ade65ea6f7d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Crocombe wrote:
> I was setting the tag to -1 in a certain spot (which indicates
> that you want to see all packets, regardless of their tag), but
> unhelpfully changing it to 0 before calling raw1394_iso_recv_start...
> 
> ...dangit, though.  Looking at the data stream, the tag *is* zero.
> 
> Stefan, isn't the line:
> 
>         /* match on specified tags */
>         contextMatch = tag_mask << 28;
> 
> in ohci_iso_recv_start() wrong?  The register looks to work like this.
>  The tag field is two bits.
> 
> if you want to match on 11b, then set bit tag3 (bit 31)
> if you want to match on 10b, then set bit tag2 (bit 30)
> if you want to match on 01b, then set bit tag1 (bit 29)
> if you want to match on 00b, then set bit tag0 (bit 28)
> 
> Which makes the shift obviously wrong.  Passing in '3' to match on tag
> 11b will have you instead set bits 29 and 28, and you will match on
> 01b and 00b.  Passing in '0' will completely bone you: no bits will be
> turned on.  Passing in '-1' to match all bits does work, though.

The question is, what is tag_mask in libraw1394's
    int raw1394_iso_recv_start(raw1394handle_t handle,
                               int start_on_cycle,
                               int tag_mask,
                               int sync);
supposed to mean in the first place?  It is not entirely documented, at
least not in the currently online documentation.

However, as it works now, tag_mask is obviously nothing else than the
highest 4 bits of the OHCI-1394 1.1 iso receive contextMatch register,
which is...

> You'd have to know to pass in 0x8 to match for tag 11b, which is a
> skosh counterintuitive

...counterintuitive and apparently undocumented.

> and probably not what was intended.

How can we tell?  The author of libraw1394's rawiso API should confirm
or deny that. :-)

> Here's my crap patch.  It appears to Work For Me(tm).
> 
> --- ohci1394.c  2006-12-04 16:52:10.916044780 -0700
> +++ modified_ohci1394.c 2006-12-13 07:22:07.613917511 -0700
> @@ -1491,7 +1491,18 @@
>         reg_write(recv->ohci, recv->ContextControlSet, command);
> 
>         /* match on specified tags */
> -       contextMatch = tag_mask << 28;
> +        switch (tag_mask)
> +        {
> +       case -1: contextMatch = tag_mask << 28; break;
> +       case 0: contextMatch = (1 << 28); break;
> +       case 1: contextMatch = (1 << 29); break;
> +       case 2: contextMatch = (1 << 30); break;
> +       case 3: contextMatch = (1 << 31); break;
> +       default:
> +               DBGMSG("Invalid tag_mask %0x, matching all tags",tag_mask);
> +               contextMatch = tag_mask << 28;
> +               break;
> +       }
> 
>         if (iso->channel == -1) {
>                 /* enable multichannel reception */
> 
> 
> So nevermind.  I'm totally vindicated and my code is, as always,
> flawless.  Cough.

We could do this, but this would have two disadvantages:
 - We change the kernel's userspace ABI.  This is only done if serious
   bugs of an ABI need to be fixed.
 - We loose the ability to match two or three tags out of four, FWIW.
   The proposed patch can match only one or all four tags.

How about leaving ohci1394 as it is but document tag_mask better in
libraw1394's inline doxygen(?) comments, and maybe add an enum or macros
to be used as values of raw1394_iso_recv_start's tag_mask argument?

/* can be ORed together */
#define RAW1394_IR_MATCH_TAG_0       1
#define RAW1394_IR_MATCH_TAG_1       2
#define RAW1394_IR_MATCH_TAG_2       4
#define RAW1394_IR_MATCH_TAG_3       8
#define RAW1394_IR_MATCH_ALL_TAGS   -1

or

/* can be used for tag = 0...3 and ORed together for multiple tags */
#define RAW1394_IR_MATCH_TAG(tag)   (1<<((tag)&3))
#define RAW1394_IR_MATCH_ALL_TAGS   -1

-- 
Stefan Richter
-=====-=-==- ==-- -==-=
http://arcgraph.de/sr/
