Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUBRQ14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267071AbUBRQ14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:27:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37610 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266186AbUBRQ1y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:27:54 -0500
Date: Wed, 18 Feb 2004 16:27:44 +0000
From: Matthew Wilcox <willy@debian.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Matthew Wilcox <willy@debian.org>,
       Sundarapandian Durairaj <sundarapandian.durairaj@intel.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@zip.com.au>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Expanded PCI config space (against 2.6.3-rc4)
Message-ID: <20040218162744.GL11824@parcelfarce.linux.theplanet.co.uk>
References: <20040217163744.GU31168@parcelfarce.linux.theplanet.co.uk> <20040218142141.GK11824@parcelfarce.linux.theplanet.co.uk> <40338F51.1030502@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40338F51.1030502@didntduck.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 11:14:09AM -0500, Brian Gerst wrote:
> Matthew Wilcox wrote:
> >@@ -55,8 +55,11 @@ struct pci_fixup pcibios_fixups[1];
> > 
> > #define PCI_SAL_ADDRESS(seg, bus, devfn, reg) \
> > 	((u64)(seg << 24) | (u64)(bus << 16) | \
> >-	 (u64)(devfn << 8) | (u64)(reg))
> >+	 (u64)(devfn << 8) | (u64)(reg)), 0
> > 
> >+#define PCI_SAL_EXT_ADDRESS(seg, bus, devfn, reg) \
> >+	((u64)(seg << 28) | (u64)(bus << 20) | \
> >+	 (u64)(devfn << 12) | (u64)(reg)), 1
> > 
> > static int
> > pci_sal_read (int seg, int bus, int devfn, int reg, int len, u32 *value)
> >
> > 
> >-	result = ia64_sal_pci_config_read(PCI_SAL_ADDRESS(seg, bus, devfn, 
> >reg), len, &data);
> >+	if ((seg < 256) && (reg < 256)) {
> >+		result = ia64_sal_pci_config_read(PCI_SAL_ADDRESS(seg, bus, 
> >devfn, reg), len, &data);
> >+	} else {
> >+		result = ia64_sal_pci_config_read(PCI_SAL_EXT_ADDRESS(seg, 
> >bus, devfn, reg), len, &data);
> >+	}
> > 
> 
> Having PCI_SAL_*ADDRESS() return 2 values is counter-intuituitive, since 
> it looks like a normal function call.  Just add the type flag to the 
> ia64_sal_pci_config_* call directly.

um, it doesn't look like a normal function call.  it looks like a
macro because it's all in upper case.  if this were in a header file
or used more generally, i'd agree with you.  but it's not, it's just a
convenience macro used in 4 places in this one file.

besides, i got this wrong the first time, and combining it all into the
one macro doesn't let me get it wrong.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
