Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVCPVZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVCPVZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbVCPVZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:25:29 -0500
Received: from ozlabs.org ([203.10.76.45]:4046 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262810AbVCPVXV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:23:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16952.41973.751326.592933@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 08:24:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, riel@redhat.com,
       kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
In-Reply-To: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser writes:

> This patch cleans up AGP driver treatment of bus/device memory. Every
> use of virt_to_phys/phys_to_virt should properly be converting between
> virtual and bus addresses: this distinction really matters for the Xen
> hypervisor.

I think you are misunderstanding the distinction between physical
addresses and bus addresses.  Specifically, it seems wrong to me to be
putting bus addresses into the GATT rather than physical addresses.

For example, on my G5, physical addresses are 36 bits (in the
hardware) but bus addresses are only 32 bits.  Using bus addresses in
the GATT would mean that I couldn't put any memory above the 4GB point
into the GATT.

The distinction is that physical addresses are what are used to access
physical memory, whereas bus addresses are what appears on some
external bus (usually PCI).  The GATT sits between an external (AGP)
bus and memory, so while the GATT is indexed using bus addresses, its
entries contain physical addresses.  So in fact virt_to_phys is the
correct thing to use to calculate values to put in GATT entries.

Paul.
