Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262454AbSJDQdV>; Fri, 4 Oct 2002 12:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSJDQdV>; Fri, 4 Oct 2002 12:33:21 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:3744 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262454AbSJDQcz>; Fri, 4 Oct 2002 12:32:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] EVMS core 1/4: evms.c
Date: Fri, 4 Oct 2002 11:05:34 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <02100307355501.05904@boiler> <02100317115209.05904@boiler> <20021004155639.A32001@infradead.org>
In-Reply-To: <20021004155639.A32001@infradead.org>
MIME-Version: 1.0
Message-Id: <02100411053405.02266@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 October 2002 09:56, Christoph Hellwig wrote:
> > +#include <net/checksum.h>
>
> Networking headers in volume managment code?

Should be <asm/checksum.h>

> > +/*
> > + * string used when validating & logging redundant metadata
> > + */
> > +u8 *evms_primary_string = "primary";
> > +EXPORT_SYMBOL(evms_primary_string);
> > +u8 *evms_secondary_string = "secondary";
> > +EXPORT_SYMBOL(evms_secondary_string);
>
> Why do you export strings?  Wouldn't a simple cpp symbol do it?
> Also the symbol names are bigger than the actual string they
> represent..  Looks a little pointless :)

These can probably be turned into #define's, but I'll have to look into it 
further.

> > +/**
> > + * SYSCTL - EVMS folder definitions/variables
> > + **/
> > +#ifdef CONFIG_PROC_FS
>
> Needs to be checked for CONFIG_SYSCTL instead.

Yep.

> > +/**********************************************************/
> > +/* START -- arch ioctl32 support                          */
> > +/**********************************************************/
>
> IMHO this is the wrong place.  What about an conditionally compiled
> evms_ioctl32.c file?

Yeah. We've already discussed what to do with this code. It was originally in 
arch/ppc64/ioctl32.c, but we moved it out of there in order to use common 
code between ppc64, sparc64, etc, and put it into evms.c for the time being. 
This may wind up in a separate file, along with the corresponding calls in 
evms_init_module and evms_exit_module.

> > +/**
> > + * find_next_volume - locates first or next logical volume
> > + * @lv:		current logical volume
> > + *
> > + * returns the next logical volume or NULL
> > + **/
>
> All user of this look like they better used list_for_each?
>
> > +
> > +/**
> > + * find_next_volume_safe - locates first or next logical volume (safe
> > for removes) + * @next_lv:	ptr to next logical volume
> > + *
> > + * returns the next logical volume or NULL
> > + **/
>
> Dito with list_for_each_safe

Quite possibly. Will look into this as well.

> > +/**
> > + * lookup_volume - finds a logical volume by minor number
> > + * @minor:	minor number of logical volume to be found
> > + *
> > + * returns the logical volume of the specified minor or NULL.
> > + **/
> > +static struct evms_logical_volume *
> > +lookup_volume(int minor)
>
> Very bad if you ever want to be able to use more than one major
> number.

Well, we've been under the impression that linux be going to 12-bit majors 
and 20-bit minors at some point in the future. That would allow for 1 million 
volumes under the EVMS driver. If this is so, would there be any reason to 
use more than one major?

> > +/**********************************************************/
> > +/* START -- exported functions/Common Services            */
> > +/**********************************************************/
> > +
> > +/**
> > + * evms_cs_get_version - returns the current EVMS version
> > + * @major:	returned major value
> > + * @minor:	returned minor value
> > + **/
> > +void
> > +evms_cs_get_version(int *major, int *minor)
> > +{
> > +	*major = EVMS_MAJOR_VERSION;
> > +	*minor = EVMS_MINOR_VERSION;
> > +}
> > +
> > +EXPORT_SYMBOL(evms_cs_get_version);
>
> Scap this.  Modules under linux aren't binary compatible.

This can go. I don't think anyone calls it anymore.

> > +int
> > +evms_cs_check_version(struct evms_version *required,
> > +		      struct evms_version *actual)
> > +{
> > +	if ((required->major != actual->major) ||
> > +	    (required->minor > actual->minor) ||
> > +	    ((required->minor == actual->minor) &&
> > +	     (required->patchlevel > actual->patchlevel)))
> > +		return (-EINVAL);
> > +	return 0;
> > +}
> > +
> > +EXPORT_SYMBOL(evms_cs_check_version);
>
> Dito.

This function is also used to check volume metadata versions, not just module 
versions.

> > +#define CRC_POLYNOMIAL     0xEDB88320L
> > +static u32 crc_table[256];
> > +static u32 crc_table_built = FALSE;
> > +
> > +/**
> > + * build_crc_table
> > + *
> > + * initialzes the internal crc table
> > + **/
> > +static void
> > +build_crc_table(void)
> > +{
> > +	u32 i, j, crc;
> > +
> > +	for (i = 0; i <= 255; i++) {
> > +		crc = i;
> > +		for (j = 8; j > 0; j--) {
> > +			if (crc & 1)
> > +				crc = (crc >> 1) ^ CRC_POLYNOMIAL;
> > +			else
> > +				crc >>= 1;
> > +		}
> > +		crc_table[i] = crc;
> > +	}
> > +	crc_table_built = TRUE;
> > +}
>
> Is this a different crc from the lib/crc32.c one?

I'll have to check. If the common library code can be used, then we can 
remove this.

> > +int
> > +evms_cs_volume_request_in_progress(kdev_t dev,
> > +				   int operation, int *current_count)
> > +{
> > +	struct evms_logical_volume *volume = lookup_volume(minor(dev));
> > +	if (!volume || !volume->node) {
> > +		return -ENODEV;
> > +	}
> > +	if (operation > 0) {
> > +		atomic_inc(&volume->requests_in_progress);
> > +	} else if (operation < 0) {
> > +		atomic_dec(&volume->requests_in_progress);
> > +	}
> > +	if (current_count) {
> > +		*current_count = atomic_read(&volume->requests_in_progress);
> > +	}
> > +	return 0;
>
> This function should be three ones for the different functionality.

I suppose. Seems like a matter of personal preference.

> Also kdev_t won't last long for block devices..

True. The calls to this function from the plugins look kind of kludgy due to 
the kdev_t, so we'll try to discuss different ways to achieve this 
functionality.

> > +static int
> > +evms_ioctl_cmd_get_info_level(void *arg)
> > +{
> > +	/* copy info to userspace */
> > +	if (copy_to_user(arg, &evms_info_level, sizeof (evms_info_level)))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> >
> >
> > +
> > +/**
> > + * evms_ioctl_cmd_set_info_level
> > + * @arg:	int value
> > + *
> > + * sets the evms info (syslog logging) level
> > + *
> > + * returns: 0 = success
> > + *	    otherwise error code
> > + **/
> > +static int
> > +evms_ioctl_cmd_set_info_level(void *arg)
> > +{
> > +	int temp;
> > +
> > +	/* copy info from userspace */
> > +	if (copy_from_user(&temp, arg, sizeof (temp)))
> > +		return -EFAULT;
> > +	evms_info_level = temp;
> > +
> > +	return 0;
> > +}
>
> Didn't you already export these two through /proc?

I don't see any reason why both interfaces can't exist. What if SYSCTL isn't 
enabled (as hard as that might be to imagine)?

> > +	if (qv->command) {
> > +		/* After setting the volume to
> > +		 * a quiesced state, there could
> > +		 * be threads (on SMP systems)
> > +		 * that are executing in the
> > +		 * function, evms_handle_request,
> > +		 * between the "wait_event" and the
> > +		 * "atomic_inc" lines. We need to
> > +		 * provide a "delay" sufficient
> > +		 * to allow those threads to
> > +		 * to reach the atomic_inc's
> > +		 * before executing the while loop
> > +		 * below. The "schedule" call should
> > +		 * provide this.
> > +		 */
> > +		schedule();
> > +		/* wait for outstanding requests to complete */
> > +		while (atomic_read(&volume->requests_in_progress) > 0)
> > +			schedule();
>
> ever heard of waitqueues and wait_event?

This can probably be changed.


Thanks for the input!

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
