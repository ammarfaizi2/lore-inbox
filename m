Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbTDKJJe (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 05:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263337AbTDKJJe (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 05:09:34 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:39646 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S262992AbTDKJJ2 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 05:09:28 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: kernel support for non-English user messages
Date: Fri, 11 Apr 2003 10:21:16 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAIEBJCGAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <1050001294.12494.11.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

 >> If we use 32-bit hash codes, there's a real chance of different
 >> messages

 > There are less than 65536 files each of which is less than 65536
 > lines long, so it seems that a properly chosen automated index
 > ought to be collision free ?

Some thoughts on that:

 1. If the printk() messages are internationalised, we are going to
    see log extracts posted here in various languages, including some
    that the relevant maintainers don't understand. To stand any
    realistic chance of dealing with the resultant bug reports, we
    need to include the message code in the report so we can just
    feed the various reports through a tool that translates them into
    our preferred language.

 2. For the above to work, we need the following guarantees:

     a. A particular message code always refers to the same message.

     b. A particular message is always referred to by the same
        message code.

 3. To obtain these guarantees, we need to ensure that the translation
    tool supplied with any particular kernel can handle all message
    codes from that kernel or from any earlier kernel in its direct
    ancestry. We thus can't reuse message codes once issued.

 4. In some languages, the parameters will need to be specified in a
    different order to the English order.

 5. We wish to keep the kernel size to a minimum.

The combination of the above points would lead me to suggest the
following design:

 1. The printk() function must NEVER be on the RHS of any #define
    statement. Many source files currently do this, and it kills any
    hope of an automated tool going through the kernel sources and
    allocating message numbers, irrespective of the numbering method
    chosen.

 2. Given the above, it would be possible to change the compilation
    sequence such that the message indexing tool runs first and
    pre-processes each printk() call to replace the format string with
    an index into a table of message formats. This table would contain
    in each row first the message code allocated to that row, then the
    format string, and finally a key to the parameter order to be used.
    The table generated would thus be the English language file, and
    would be generated such that any existing messages therein were
    reused. This would have the benefit that where any particular
    message format occurs multiple times, they would be merged.

 3. Given all of the above, a new printk() function would be written
    to index into the table and pick out the relevant row, then to
    produce a call to the current printk() function (renamed as
    printk2() or whatever) with its parameters sorted into the order
    specified by the final field in the table.

 4. Where functions will be called prior to such internationalisations
    being available, they would call the printk2() function directly,
    and the message indexing tool would be designed to ignore such
    calls when doing its parsing.

 5. The next step of the compilation would process the files produced
    by this tool rather than the original kernel sources.

This would then lead to the actual messages existing in a separate
directory in the kernel source tree with the `make *config` process
allowing one to select the appropriate language to be used, and
auto-indexing the available languages (not hard to do). The compilation
would then run a separate tool that created a *.h file with the relevant
version of the table for that particular compilation.

One detail that would need to be handled is this: If the selected
language file did not contain an entry for a particular message code,
the entry for that message code would need to be extracted from the
English language file. To help with translation, it should produce a
report stating which message codes it had to do that for.

Also, the table would want to be sorted by message number to speed up
access to the individual messages.

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.471 / Virus Database: 269 - Release Date: 10-Apr-2003

