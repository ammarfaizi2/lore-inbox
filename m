Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVLHWEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVLHWEM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVLHWEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:04:12 -0500
Received: from fmr17.intel.com ([134.134.136.16]:45450 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751233AbVLHWEL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:04:11 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] ACPI owner_id limit too low
Date: Thu, 8 Dec 2005 14:03:59 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E03A96856@orsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] ACPI owner_id limit too low
thread-index: AcX8N0um465Tr+scRj2QzLI/l1HdqwAC6T4Q
From: "Moore, Robert" <robert.moore@intel.com>
To: "Alex Williamson" <alex.williamson@hp.com>,
       "Carl-Daniel Hailfinger" <c-d.hailfinger.devel.2005@gmx.net>
Cc: "Brown, Len" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>,
       <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 08 Dec 2005 22:04:00.0863 (UTC) FILETIME=[4B70F6F0:01C5FC43]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have increased the number of owner IDs to 255 in the most recent
version of ACPICA, 20051202. This should hit Linux soon.

Additionally, we plan to conserve OwnerIDs by not using them for tables
that can never be unloaded, to be implemented in a future release.
However, 255 Ids should be plenty for now.

Here is the text from the release memo:

Increased the number of available Owner Ids for namespace object
tracking from 32 to 255. This should eliminate the OWNER_ID_LIMIT
exceptions seen on some machines with a large number of ACPI tables
(either static or dynamic).


Bob


> -----Original Message-----
> From: acpi-devel-admin@lists.sourceforge.net [mailto:acpi-devel-
> admin@lists.sourceforge.net] On Behalf Of Alex Williamson
> Sent: Thursday, December 08, 2005 12:37 PM
> To: Carl-Daniel Hailfinger
> Cc: Brown, Len; linux-kernel@vger.kernel.org; acpi-
> devel@lists.sourceforge.net
> Subject: Re: [ACPI] ACPI owner_id limit too low
> 
> On Thu, 2005-12-08 at 21:23 +0100, Carl-Daniel Hailfinger wrote:
> 
> > > -	for (i = 0; i < 32; i++) {
> > > -		if (!(acpi_gbl_owner_id_mask & (1 << i))) {
> > > +	for (i = 0; i < 64; i++) {
> > > +		if (!(acpi_gbl_owner_id_mask & (1UL << i))) {
> >
> > Shouldn't this be 1ULL if you intend it to be 64 bit wide on a
> > 32 bit arch?
> 
>    Yes, sorry I overlooked that.  Here's an updated patch.  Thanks,
> 
> 	Alex
> 
> Signed-off-by: Alex Williamson <alex.williamson@hp.com>
> ---
> 
> diff -r 03055821672a drivers/acpi/utilities/utmisc.c
> --- a/drivers/acpi/utilities/utmisc.c	Mon Dec  5 01:00:10 2005
> +++ b/drivers/acpi/utilities/utmisc.c	Wed Dec  7 14:55:58 2005
> @@ -84,14 +84,14 @@
> 
>  	/* Find a free owner ID */
> 
> -	for (i = 0; i < 32; i++) {
> -		if (!(acpi_gbl_owner_id_mask & (1 << i))) {
> +	for (i = 0; i < 64; i++) {
> +		if (!(acpi_gbl_owner_id_mask & (1ULL << i))) {
>  			ACPI_DEBUG_PRINT((ACPI_DB_VALUES,
> -					  "Current owner_id mask: %8.8X
New ID:
> %2.2X\n",
> +					  "Current owner_id mask:
%16.16lX New ID:
> %2.2X\n",
>  					  acpi_gbl_owner_id_mask,
>  					  (unsigned int)(i + 1)));
> 
> -			acpi_gbl_owner_id_mask |= (1 << i);
> +			acpi_gbl_owner_id_mask |= (1ULL << i);
>  			*owner_id = (acpi_owner_id) (i + 1);
>  			goto exit;
>  		}
> @@ -106,7 +106,7 @@
>  	 */
>  	*owner_id = 0;
>  	status = AE_OWNER_ID_LIMIT;
> -	ACPI_REPORT_ERROR(("Could not allocate new owner_id (32 max),
> AE_OWNER_ID_LIMIT\n"));
> +	ACPI_REPORT_ERROR(("Could not allocate new owner_id (64 max),
> AE_OWNER_ID_LIMIT\n"));
> 
>        exit:
>  	(void)acpi_ut_release_mutex(ACPI_MTX_CACHES);
> @@ -123,7 +123,7 @@
>   *              control method or unloading a table. Either way, we
would
>   *              ignore any error anyway.
>   *
> - * DESCRIPTION: Release a table or method owner ID.  Valid IDs are 1
- 32
> + * DESCRIPTION: Release a table or method owner ID.  Valid IDs are 1
- 64
>   *
> 
>
************************************************************************
**
> ****/
> 
> @@ -140,7 +140,7 @@
> 
>  	/* Zero is not a valid owner_iD */
> 
> -	if ((owner_id == 0) || (owner_id > 32)) {
> +	if ((owner_id == 0) || (owner_id > 64)) {
>  		ACPI_REPORT_ERROR(("Invalid owner_id: %2.2X\n",
owner_id));
>  		return_VOID;
>  	}
> @@ -158,8 +158,8 @@
> 
>  	/* Free the owner ID only if it is valid */
> 
> -	if (acpi_gbl_owner_id_mask & (1 << owner_id)) {
> -		acpi_gbl_owner_id_mask ^= (1 << owner_id);
> +	if (acpi_gbl_owner_id_mask & (1ULL << owner_id)) {
> +		acpi_gbl_owner_id_mask ^= (1ULL << owner_id);
>  	}
> 
>  	(void)acpi_ut_release_mutex(ACPI_MTX_CACHES);
> diff -r 03055821672a include/acpi/acglobal.h
> --- a/include/acpi/acglobal.h	Mon Dec  5 01:00:10 2005
> +++ b/include/acpi/acglobal.h	Wed Dec  7 14:55:58 2005
> @@ -211,7 +211,7 @@
>  ACPI_EXTERN u32 acpi_gbl_rsdp_original_location;
>  ACPI_EXTERN u32 acpi_gbl_ns_lookup_count;
>  ACPI_EXTERN u32 acpi_gbl_ps_find_count;
> -ACPI_EXTERN u32 acpi_gbl_owner_id_mask;
> +ACPI_EXTERN u64 acpi_gbl_owner_id_mask;
>  ACPI_EXTERN u16 acpi_gbl_pm1_enable_register_save;
>  ACPI_EXTERN u16 acpi_gbl_global_lock_handle;
>  ACPI_EXTERN u8 acpi_gbl_debugger_configuration;
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD
SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
