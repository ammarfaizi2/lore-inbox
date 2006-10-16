Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWJPAQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWJPAQm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 20:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWJPAQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 20:16:42 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:6539 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932210AbWJPAQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 20:16:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ukSRVcvQK+fJRSQiblR/Im7fYQSHrIGaMlimXvDdyS1Z42nlwnEBXVy4v8A2JTFWjqxFIKyZN5gjZWKz81xvWzVn1LrTZxNaL+UV1+ou7qeV5nmpYHEQ1TQthWKMel5JH3wQO8EWM3B280a6b0YO0UvGDKtZDxO8L7gvog4GJcE=  ;
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Date: Sun, 15 Oct 2006 17:16:35 -0700
User-Agent: KMail/1.7.1
Cc: alan@lxorguk.ukuu.org.uk, matthew@wil.cx, val_henson@linux.intel.com,
       netdev@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, gregkh@suse.de
References: <1160161519800-git-send-email-matthew@wil.cx> <200610151545.59477.david-b@pacbell.net> <20061015161834.f96a0761.akpm@osdl.org>
In-Reply-To: <20061015161834.f96a0761.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610151716.36337.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I agree that set_mwo() should set MWI if possible, and fail cleanly
> > if it couldn't (for whatever reason).  Thing is, choosing to treat
> > that as an error must be the _driver's_ choice ... it'd be wrong to force
> > that policy into the _interface_ by forcing must_check etc.
> 
> No.  If pci_set_mwi() detects an unexpected error then the driver should
> take some action: report it, recover from it, fail to load, etc.  If the
> driver fails to do any of this then it's a buggy driver.

But what is an "unexpected" "error"?  Not every fault that's unexpected
is an error; consider a page fault.

Consider also kfree(NULL).  The same motivation for drivers not needing
to validate that parameter is behind arguing that device drivers should
not need to poke around in PCI config space to verify that the device
supports MWI; and should have the flexibility to ignore the return code,
just like kfree() returns no value.


> You, the driver author _do not know_ what pci_set_mwi() does at present, on
> all platforms, nor do you know what it does in the future. 

I know that it enables MWI accesses ... or fails.  Beyond that, there
should be no reason to care.  If the hardware can use a lower-overhead
type of PCI bus cycle, I want it to do so.  If not, no sweat.


> This is not a terribly important issue, and it is far from the worst case
> of missed error-checking which we have in there. 

The reason I think it's important enough to continue this discussion is
that as it currently stands, it's a good example of a **BAD** interface
design ... since it's pointlessly marked as must_check.  (See appended
patch to fix that issue.)

If you wouldn't want all callers of kfree() to say "if (ptr) kfree(ptr);";
why then would anyone want to demand

	... read the pci config space byte (and cleanly handle errors) ...
	... check for the MWI bit ...
	... if it's set (so we "expect" this next call to succeed) then:
		... call pci_set_mwi() ...
		... test set_mwi() value ...
		... ignore that value ...

where the first three lines duplicate code _inside_ pci_set_mwi(), and the
last two lines are obviously a pure waste of code and effort.  I'd want to
know the criteria by which "if(ptr)" is judged a waste of effort in all
callers, but that more extensive PCI configspace logic was not...

- Dave

-------------------- CUT HERE

Remove bogus annotation of pci_set_mwi() as __must_check.  It's completely
reasonable for drivers to not care about the return code, when all they're
doing is enabling an optional performance-improving mechanism that's often
not even available.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -499,7 +499,7 @@ int __must_check pci_enable_device_bars(
 void pci_disable_device(struct pci_dev *dev);
 void pci_set_master(struct pci_dev *dev);
 #define HAVE_PCI_SET_MWI
-int __must_check pci_set_mwi(struct pci_dev *dev);
+int pci_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
 void pci_intx(struct pci_dev *dev, int enable);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);

