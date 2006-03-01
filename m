Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751929AbWCAWvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbWCAWvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 17:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWCAWvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 17:51:04 -0500
Received: from fmr19.intel.com ([134.134.136.18]:18311 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751929AbWCAWvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 17:51:02 -0500
Subject: Re: [Pcihpd-discuss] [patch] pci hotplug: add common acpi
	functions to core
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com
In-Reply-To: <44050100.8070003@jp.fujitsu.com>
References: <1141174017.28842.6.camel@whizzy>
	 <44050100.8070003@jp.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Mar 2006 14:56:30 -0800
Message-Id: <1141253790.13333.34.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 01 Mar 2006 22:50:49.0393 (UTC) FILETIME=[95BDE210:01C63D82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 11:03 +0900, Kenji Kaneshige wrote:
> Hi Kristen,
> 
> This looks very nice to me!
> 
> Here is one comment.
> 
> > +int is_root_bridge(acpi_handle handle)
> > +{
> > +	acpi_status status;
> > +	struct acpi_device_info *info;
> > +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
> > +	int i;
> > +
> > +	status = acpi_get_object_info(handle, &buffer);
> > +	if (ACPI_SUCCESS(status)) {
> > +		info = buffer.pointer;
> > +		if ((info->valid & ACPI_VALID_HID) &&
> > +			!strcmp(PCI_ROOT_HID_STRING,
> > +					info->hardware_id.value)) {
> > +			acpi_os_free(buffer.pointer);
> > +			return 1;
> > +		}
> > +		if (info->valid & ACPI_VALID_CID) {
> > +			for (i=0; i < info->compatibility_id.count; i++) {
> > +				if (!strcmp(PCI_ROOT_HID_STRING,
> > +					info->compatibility_id.id[i].value)) {
> > +					acpi_os_free(buffer.pointer);
> > +					return 1;
> > +				}
> > +			}
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(is_root_bridge);
> 
> I think this seems to leak memory (buffer.pointer), though
> I guess you just copy and paste from the original code. I think
> we need to free buffer.pointer whenever acpi_get_object_info()
> returns as success.
> 
> Thanks,
> Kenji Kaneshige

Ah hah, you are right.  Yes, I did just cut and paste the original code
- and this just makes me happy I'm doing this because this bug is
currently duplicated in 2 drivers since they all cut and pasted the same
buggy code.  Soon we will just share the same 1 piece of buggy code.


