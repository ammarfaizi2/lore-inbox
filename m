Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbTLGR4v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 12:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264474AbTLGR4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 12:56:51 -0500
Received: from enigma.barak.net.il ([212.150.48.99]:17883 "EHLO
	enigma.barak.net.il") by vger.kernel.org with ESMTP id S264473AbTLGR4s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 12:56:48 -0500
From: "Amir Hermelin" <amir@montilio.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Creating a page struct for HIGHMEM pages
Date: Sun, 7 Dec 2003 19:56:17 +0200
Organization: Montilio
Message-ID: <00ac01c3bceb$757b30d0$1d01a8c0@CARTMAN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <20031207162203.GQ19856@holomorphy.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks William.
I may be missing something a little more basic: I have a contiguous physical
memory area (IO memory), and I want to manage it with struct pages.  If I'm
to write to the page I need to kmap it, therefore (as I understand it) I
need to zero the ->virtual field.   What I don't understand is how, given
the struct page I've allocated and filled out, is the page correlated with
the correct physical memory.  Where do I put the information that struct
page X points to physical address Y, so that when I kmap(X) I get a virtual
address pointing to Y?

Thanks,
Amir.


-----Original Message-----
From: William Lee Irwin III [mailto:wli@holomorphy.com] 
Sent: Sunday, December 07, 2003 6:22 PM
To: Amir Hermelin
Cc: linux-kernel@vger.kernel.org
Subject: Re: Creating a page struct for HIGHMEM pages


On Sun, Dec 07, 2003 at 06:02:46PM +0200, Amir Hermelin wrote:
> Suppose I want to create a page struct pointing to high memory (e.g. 
> IO mapped memory), that is, allocate the memory for the page struct 
> myself and fill in the values, what are the necessary flags/values 
> (other than the 'virtual' field) I must be sure to set?  Does the 
> page* need to be located anywhere specific?  Does the pte field need 
> to be set in anyway? The question is relevant to kernel versions 
> 2.4.20 and up.

I'm not entirely sure this is safe (I don't know of anything doing it off
the top of my head or any guarantee it should work), but PG_reserved is an
absolute requirement at the very least. ->virtual is likely irrelevant.
Also, COW userspace mappings of such beasts are illegal since the physical
address can't be calculated for do_wp_page() to do its copy. Codepaths
assuming it's in a zone and so on must also be avoided. You'll need to set
VM_RESERVED on the vma, since the page structure can't be looked up via
pte_page(). If you want faults handled on it, you'll also have to define
your own ->nopage() method.

I generally prefer setting VM_RESERVED and prefaulting in ->f_op->mmap(),
though that may not be feasible in some scenarios. Handling this would be
much easier if drivers could override fault handling methods and the like.

-- wli


