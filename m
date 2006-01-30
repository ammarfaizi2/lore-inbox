Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWA3Ufb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWA3Ufb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWA3Ufa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:35:30 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:42460 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964963AbWA3Ufa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:35:30 -0500
Subject: Re: [PATCH] record last user if malloc request is exact 4k
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060130202527.GB12315@suse.de>
References: <20060130174919.GA7599@suse.de>
	 <84144f020601301223j709ce2bco707ee73cf2d583b4@mail.gmail.com>
	 <20060130202527.GB12315@suse.de>
Date: Mon, 30 Jan 2006 22:35:25 +0200
Message-Id: <1138653326.21112.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 30, Pekka Enberg wrote:
> > For architectures that have 4K pages, adding debugging overhead to 4K
> > objects is pretty much the worst case. Any particular reason you want
> > this?

On Mon, 2006-01-30 at 21:25 +0100, Olaf Hering wrote:
> I'm just curious.

Oh, okay. One or more pages are allocated for each slab depending on
object size. Each slab is then divided into equal-sized buffers which
must fit at one object. A buffer also has optional padding so that
objects respect alignment rules given to a cache. In addition, when
CONFIG_DEBUG_SLAB is enabled, the buffer contains space for red-zone on
left and right of the object and last user information.

When all debugging is enable, the total overhead is padding plus 4 *
sizeof(void *) for red-zoning and one more sizeof(void *) for the last
caller address. If you allow debugging for 4K objects, you have huge
internal fragmentation for both 4 KB and 8 KB pages (almost one full
page). The current 4095 limit isn't perfect either but increasing will
only make things worse. I think it's designed for
<linux/kmalloc_sizes.h> so that the last general object size with
debugging is 2048.

			Pekka

