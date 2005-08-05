Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263102AbVHET3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbVHET3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbVHET1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:27:05 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:22873 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263102AbVHETZx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:25:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EWwfqUvYQmSDKeTFVpAj6EjM7r8fAuu8KoToUrdVoypAlVvu6dbnmQBJ96EX2bWI+kM6TfEWFQSCM/339UVoyxFwoKszj7ef9oorbHlNs6I4GYo0dscA7f32Pe8+KTEATTXyhslHF/1sLURizS05o9eg9Xropr90Ow0GMDz8C/A=
Message-ID: <86802c4405080512254b9cd496@mail.gmail.com>
Date: Fri, 5 Aug 2005 12:25:50 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Roland Dreier <rolandd@cisco.com>, linville@tuxdriver.com, gregkh@suse.de,
       torvalds@osdl.org
Subject: Re: mthca and LinuxBIOS
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <86802c44050805112661d889aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20057281331.dR47KhjBsU48JfGE@cisco.com>
	 <86802c4405080410236ba59619@mail.gmail.com>
	 <86802c4405080411013b60382c@mail.gmail.com> <521x59a6tb.fsf@cisco.com>
	 <86802c440508041230143354c2@mail.gmail.com> <52slxp6o5b.fsf@cisco.com>
	 <86802c440508051103500f6942@mail.gmail.com>
	 <86802c4405080511079d01532@mail.gmail.com> <52psss5k1x.fsf@cisco.com>
	 <86802c44050805112661d889aa@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_restore_bars cause that.
it didn't restore that according to if resource is 64 bit or not. So
it overwirte upper 32 bit with 0.

YH

file:1b34fc56067ed8ae0ba9b32f46679e13068bb86c ->
file:65ea7d25f6911d7396e19afbf4bb2738906376f7
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -222,6 +222,37 @@ pci_find_parent_resource(const struct pc
}
/**
+ * pci_restore_bars - restore a devices BAR values (e.g. after wake-up)
+ * @dev: PCI device to have its BARs restored
+ *
+ * Restore the BAR values for a given device, so as to make it
+ * accessible by its driver.
+ */
+void
+pci_restore_bars(struct pci_dev *dev)
+{
+ int i, numres;
+
+ switch (dev->hdr_type) {
+ case PCI_HEADER_TYPE_NORMAL:
+ numres = 6;
+ break;
+ case PCI_HEADER_TYPE_BRIDGE:
+ numres = 2;
+ break;
+ case PCI_HEADER_TYPE_CARDBUS:
+ numres = 1;
+ break;
+ default:
+ /* Should never get here, but just in case... */
+ return;
+ }
+
+ for (i = 0; i < numres; i ++)
+ pci_update_resource(dev, &dev->resource[i], i);
+}
+
+/**

On 8/5/05, yhlu <yhlu.kernel@gmail.com> wrote:
> before I do the cg-update this morning, it didn't mask out the upper 8 bit.
> 
> YH
> 
> On 8/5/05, Roland Dreier <rolandd@cisco.com> wrote:
> >     yhlu> ps.  some kernel pci code patch broke sth yesterday night.
> >     yhlu> it mask out bit [32-39]
> >
> > Is it possible that all your problems are coming from the PCI setup
> > code incorrectly assigning BARs?
> >
> >  - R.
> >
>
