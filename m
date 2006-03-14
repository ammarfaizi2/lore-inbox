Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751716AbWCNAfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbWCNAfn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 19:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWCNAfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 19:35:43 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:63360 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751473AbWCNAfm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 19:35:42 -0500
Date: Mon, 13 Mar 2006 16:39:57 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@sous-sol.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 3/24] i386 Vmi interface definition
Message-ID: <20060314003956.GE12807@sorel.sous-sol.org>
References: <200603131801.k2DI1EAe005650@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131801.k2DI1EAe005650@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Master definition of VMI interface, including calls, constants, and
> interface version.

> +/* VROM call table definitions */
> +#define VROM_CALL_LEN             32
> +
> +typedef struct VROMCallEntry {
> +   char f[VROM_CALL_LEN];
> +} VROMCallEntry;

And the call entry is meant to be handled in whatever mechanism hypervisor
prefers for its entry points (ABI constraints notwithstanding) as in,
arbitrary software interrupt, or call gate, etc?  I guess for transparent
it has to, since those would be local calls.   Quite similar to the
hypercall entry point that Xen places on the hypercall_page, so easily
compatible.

> +typedef struct VROMHeader {
> +   VMI_UINT16          romSignature;             // option ROM signature
> +   VMI_INT8            romLength;                // ROM length in 512 byte chunks
> +   unsigned char       romEntry[4];              // 16-bit code entry point
> +   VMI_UINT8           romPad0;                  // 4-byte align pad
> +   VMI_UINT32          vRomSignature;            // VROM identification signature
> +   VMI_UINT8           APIVersionMinor;          // Minor version of API
> +   VMI_UINT8           APIVersionMajor;          // Major version of API
> +   VMI_UINT8           reserved0;                // Reserved for expansion
> +   VMI_UINT8           reserved1;                // Reserved for expansion
> +   VMI_UINT32          reserved2;                // Reserved for expansion
> +   VMI_UINT32          reserved3;                // Reserved for private use
> +   VMI_UINT16          pciHeaderOffset;          // Offset to PCI OPROM header
> +   VMI_UINT16          pnpHeaderOffset;          // Offset to PnP OPROM header
> +   VMI_UINT32          romPad3;                  // PnP reserverd / VMI reserved
> +   VROMCallEntry       romCallReserved[3];       // Reserved call slots
> +} VROMHeader;

The document is slightly more descriptive.  The above reserved slots
are shown as:

	char		reserved[32];
	char		elfHeader[64];

But that's only 3 (0-2).  I think I'm missing some small bit of magic.

> +typedef struct VROMCallTable {
> +   VROMCallEntry    vromCall[128];           // @ 0x80: ROM calls 4-127
> +} VROMCallTable;

That comment eludes me.  Are 0-3 special somehow (IOW, I thought it was
just 0-2 as per above), and is it suggesting int 0x80?

> +// Historical 3.X revisions
> +//#define MIN_VMI_API_REV_MINOR	        1 /* GetFlags_CLI is used */
> +//#define MIN_VMI_API_REV_MINOR	        2 /* STI_SYSEXIT is used */
> +//#define MIN_VMI_API_REV_MINOR	        3 /* IN/OUT are used */
> +//#define MIN_VMI_API_REV_MINOR         4 /* Deferred calls used */
> +//#define MIN_VMI_API_REV_MINOR		5 /* SetIOPLMask is used */
> +
> +// 4.X revisions
> +//#define MIN_VMI_API_REV_MINOR		0 /* IN/OUT binary compat */

Probably not the best format for keeping changelog entries.  Although
it's worth keeping the info somehwere in documentation perhaps.

thanks,
-chris
