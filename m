Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265008AbTB0ODN>; Thu, 27 Feb 2003 09:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265037AbTB0ODM>; Thu, 27 Feb 2003 09:03:12 -0500
Received: from poup.poupinou.org ([195.101.94.96]:47662 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S265008AbTB0ODL>; Thu, 27 Feb 2003 09:03:11 -0500
Date: Thu, 27 Feb 2003 15:13:22 +0100
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] S4bios support for 2.5.63
Message-ID: <20030227141322.GV13404@poup.poupinou.org>
References: <20030226211347.GA14903@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226211347.GA14903@elf.ucw.cz>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2003 at 10:13:47PM +0100, Pavel Machek wrote:
> Hi!
> 
> This is S4bios support for 2.5.63. I'd like to see it in since it is
> easier to understand and more foolproof. Please apply,
> 
> 							Pavel
> +/******************************************************************************
> + *
> + * FUNCTION:    acpi_enter_sleep_state_s4bios
> + *
> + * PARAMETERS:  None
> + *
> + * RETURN:      Status
> + *
> + * DESCRIPTION: Perform a s4 bios request.
> + *              THIS FUNCTION MUST BE CALLED WITH INTERRUPTS DISABLED
> + *
> + ******************************************************************************/
> +
> +acpi_status
> +acpi_enter_sleep_state_s4bios (
> +	void)
> +{
> +	u32                     in_value;
> +	acpi_status             status;
> +
> +
> +	ACPI_FUNCTION_TRACE ("Acpi_enter_sleep_state_s4bios");
> +
> +	acpi_set_register (ACPI_BITREG_WAKE_STATUS, 1, ACPI_MTX_LOCK);
> +	acpi_hw_clear_acpi_status();
> +
> +	acpi_hw_disable_non_wakeup_gpes();
> +
> +	ACPI_FLUSH_CPU_CACHE();
> +
> +	status = acpi_os_write_port (acpi_gbl_FADT->smi_cmd, (acpi_integer) acpi_gbl_FADT->S4bios_req, 8);
> +
> +	do {
> +		acpi_os_stall(1000);
> +		status = acpi_get_register (ACPI_BITREG_WAKE_STATUS, &in_value, ACPI_MTX_LOCK);

Please use ACPI_MTX_DO_NOT_LOCK flags.

1- all others user land are no more scheduled, and irqs are disabled.
2- the saved memory image is the one that appar 'randomly' when the suspension
   happen, it is then possible that that we enter acpi_get_register()
3- acpi_get_register() touch one semaphore (a mutex) if you pass ACPI_MTX_LOCK,
   then it is possible that this mutex is not released:
   we are supposed to go to 'ret_point' in arch/i386/kernel/acpi/wakeup.S

4- after resuming, any try to acquire this mutex will deadlock (this will happen early
   in acpi_leave_sleep_state()).

Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
