Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbRAaVcG>; Wed, 31 Jan 2001 16:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129061AbRAaVb4>; Wed, 31 Jan 2001 16:31:56 -0500
Received: from [194.213.32.137] ([194.213.32.137]:2052 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129059AbRAaVbk>;
	Wed, 31 Jan 2001 16:31:40 -0500
Message-ID: <20010131223114.C231@bug.ucw.cz>
Date: Wed, 31 Jan 2001 22:31:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Toshiba Satellite + 2.4.1 + ACPI -- problems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

ACPI on satellite 4030cdt fails to see system battery... I traced it a
little bit, and found that 

acpi_ns_get_device_callback (
        ACPI_HANDLE             obj_handle,
        u32                     nesting_level,
        void                    *context,
        void                    **return_value)
{
        ACPI_STATUS             status;
        ACPI_NAMESPACE_NODE     *node;
        u32                     flags;
        DEVICE_ID               device_id;
        ACPI_GET_DEVICES_INFO   *info;


        info = context;

        acpi_cm_acquire_mutex (ACPI_MTX_NAMESPACE);

        node = acpi_ns_convert_handle_to_entry (obj_handle);
        if (!node) {
                acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);
                return (AE_BAD_PARAMETER);
        }

        acpi_cm_release_mutex (ACPI_MTX_NAMESPACE);

        /*
         * Run _STA to determine if device is present
         */

        printk("Running sta on %x: ", node);
        status = acpi_cm_execute_STA (node, &flags);
        if (ACPI_FAILURE (status)) {
                printk("error (%x)\n", status);
		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                return (status);
        }


~~~ triggers with status = 0x08.

Is there any patch to try / anything to help debugging?
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org


----- End forwarded message -----

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
