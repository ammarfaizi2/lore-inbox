Return-Path: <linux-kernel-owner+w=401wt.eu-S932074AbXAQWQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbXAQWQb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbXAQWQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:16:30 -0500
Received: from mx1.suse.de ([195.135.220.2]:55957 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbXAQWQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:16:25 -0500
From: Andi Kleen <ak@suse.de>
To: Chip Coldwell <coldwell@redhat.com>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8 cpu errata needed?)
Date: Thu, 18 Jan 2007 09:15:32 +1100
User-Agent: KMail/1.9.1
Cc: Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, andersen@codepoet.org, krader@us.ibm.com,
       lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <200701170829.54540.ak@suse.de> <Pine.LNX.4.64.0701170942560.2900@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0701170942560.2900@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701180915.32944.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We've just verified that configuring the graphics aperture to be
> write-combining instead of write-back using an MTRR also solves the
> problem.  It appears to be a cache incoherency issue in the graphics
> aperture.

Interesting. 

Unfortunately it is also not correct. It was intentional to 
mark the IOMMU half. of the aperture write-back, as opposed
to uncached as the AGP half. Otherwise you get illegal cache attribute 
conflicts with the memory that is being remapped which can also cause 
corruption.

The Northbridge guarantees coherency over the aperture, but 
only if the caching attributes match. 

You would need to change_page_attr() every kernel address that is mapped into 
the  IOMMU to use an uncached aperture. AGP does this, but the frequency of 
mapping for the IOMMU  is much higher and it would be prohibitively costly
unfortunately. 

In the past we saw corruptions from such conflicts, so this is more
than just theory. I suspect  you traded a more easy to trigger corruption with 
a more subtle one.

-Andi

