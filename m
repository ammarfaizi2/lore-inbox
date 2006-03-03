Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752086AbWCCHQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbWCCHQY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 02:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbWCCHQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 02:16:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3542 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752072AbWCCHQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 02:16:23 -0500
Date: Thu, 2 Mar 2006 23:14:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: davej@redhat.com, ashok.raj@intel.com, len.brown@intel.com, ak@suse.de,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Message-Id: <20060302231452.440a91c8.akpm@osdl.org>
In-Reply-To: <20060302112119.A13035@unix-os.sc.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30063BFB95@hdsmsx401.amr.corp.intel.com>
	<20060302083038.A11407@unix-os.sc.intel.com>
	<20060302184428.GB7304@redhat.com>
	<20060302112119.A13035@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> Local apic entries are only 8 bits, but it seemed to not be caught with 
> u8 return value result in the check
> 
> cpu_index >= NR_CPUS becomming always false.
> 
> drivers/acpi/processor_core.c: In function `acpi_processor_get_info':
> drivers/acpi/processor_core.c:483: warning: comparison is always false due to limited range of data type
> 
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> -----------------------------------------------------
>  drivers/acpi/processor_core.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-2.6.16-rc5-mm1/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.16-rc5-mm1.orig/drivers/acpi/processor_core.c
> +++ linux-2.6.16-rc5-mm1/drivers/acpi/processor_core.c
> @@ -395,7 +395,7 @@ static int acpi_processor_remove_fs(stru
>  #define ARCH_BAD_APICID		(0xff)
>  #endif
>  
> -static u8 convert_acpiid_to_cpu(u8 acpi_id)
> +static int convert_acpiid_to_cpu(u8 acpi_id)
>  {
>  	u16 apic_id;
>  	int i;
> @@ -421,7 +421,7 @@ static int acpi_processor_get_info(struc
>  	acpi_status status = 0;
>  	union acpi_object object = { 0 };
>  	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
> -	u8 cpu_index;
> +	int cpu_index;
>  	static int cpu0_initialized;
>  
>  	ACPI_FUNCTION_TRACE("acpi_processor_get_info");
> @@ -466,7 +466,7 @@ static int acpi_processor_get_info(struc
>  	cpu_index = convert_acpiid_to_cpu(pr->acpi_id);
>  
>  	/* Handle UP system running SMP kernel, with no LAPIC in MADT */
> -	if (!cpu0_initialized && (cpu_index == 0xff) &&
> +	if (!cpu0_initialized && (cpu_index == -1) &&
>  	    (num_online_cpus() == 1)) {
>  		cpu_index = 0;
>  	}
> @@ -480,7 +480,7 @@ static int acpi_processor_get_info(struc
>  	 *  less than the max # of CPUs. They should be ignored _iff
>  	 *  they are physically not present.
>  	 */
> -	if (cpu_index >= NR_CPUS) {
> +	if (cpu_index == -1) {
>  		if (ACPI_FAILURE
>  		    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
>  			ACPI_ERROR((AE_INFO,

On a uniprocessor build this causes a crash in acpi_processor_start():

	BUG_ON((pr->id >= NR_CPUS) || (pr->id < 0));

pr->id is 255.

I could bodge around this in various ways, but the semantics of cpu IDs in
there seem to be a bit opaque, and I suspect some more thought needs to go
into it all.

As well as uniprocessor testing ;)

