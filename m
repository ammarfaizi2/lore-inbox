Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTLGQWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 11:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTLGQWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 11:22:16 -0500
Received: from holomorphy.com ([199.26.172.102]:14809 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264450AbTLGQWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 11:22:10 -0500
Date: Sun, 7 Dec 2003 08:22:03 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Amir Hermelin <amir@montilio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Creating a page struct for HIGHMEM pages
Message-ID: <20031207162203.GQ19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Amir Hermelin <amir@montilio.com>, linux-kernel@vger.kernel.org
References: <006c01c3bcdb$92290f50$1d01a8c0@CARTMAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006c01c3bcdb$92290f50$1d01a8c0@CARTMAN>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 06:02:46PM +0200, Amir Hermelin wrote:
> Suppose I want to create a page struct pointing to high memory (e.g. IO
> mapped memory), that is, allocate the memory for the page struct myself and
> fill in the values, what are the necessary flags/values (other than the
> 'virtual' field) I must be sure to set?  Does the page* need to be located
> anywhere specific?  Does the pte field need to be set in anyway? The
> question is relevant to kernel versions 2.4.20 and up.

I'm not entirely sure this is safe (I don't know of anything doing it off
the top of my head or any guarantee it should work), but PG_reserved is
an absolute requirement at the very least. ->virtual is likely irrelevant.
Also, COW userspace mappings of such beasts are illegal since the
physical address can't be calculated for do_wp_page() to do its copy.
Codepaths assuming it's in a zone and so on must also be avoided.
You'll need to set VM_RESERVED on the vma, since the page structure
can't be looked up via pte_page(). If you want faults handled on it,
you'll also have to define your own ->nopage() method.

I generally prefer setting VM_RESERVED and prefaulting in ->f_op->mmap(),
though that may not be feasible in some scenarios. Handling this would be
much easier if drivers could override fault handling methods and the like.

-- wli
