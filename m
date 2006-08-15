Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWHOA11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWHOA11 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbWHOA11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:27:27 -0400
Received: from tango.0pointer.de ([217.160.223.3]:517 "EHLO tango.0pointer.de")
	by vger.kernel.org with ESMTP id S932754AbWHOA10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:27:26 -0400
Date: Tue, 15 Aug 2006 02:27:24 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] acpi,backlight: MSI S270 laptop support - ec_transaction()
Message-ID: <20060815002724.GB1099@tango.0pointer.de>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1120727@pdsmsx411.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <554C5F4C5BA7384EB2B412FD46A3BAD1120727@pdsmsx411.ccr.corp.intel.com>
Organization: .phi.
X-Campaign-1: ()  ASCII Ribbon Campaign
X-Campaign-2: /  Against HTML Email & vCards - Against Microsoft Attachments
X-Disclaimer-1: Diese Nachricht wurde mit einer elektronischen 
X-Disclaimer-2: Datenverarbeitungsanlage erstellt und bedarf daher 
X-Disclaimer-3: keiner Unterschrift.
User-Agent: Leviathan/19.8.0 [zh] (Cray 3; I; Solaris 4.711; Console)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14.08.06 23:25, Yu, Luming (luming.yu@intel.com) wrote:

Hi

> First of all, thanks for your patch.

You're welcome!

> >+static int acpi_ec_transaction(union acpi_ec *ec, u8 command,
> >+                               const u8 *wdata, unsigned wdata_len,
> >+                               u8 *rdata, unsigned rdata_len)
> 
> I agree the name: transaction sounds better than read/write, and
> can reduce redundant code from separate read, write function.
> But, I guess using argument : u8 address will make the patch
> looks better.

I don't understand? You mean to add an additional parameter "u8
address" which would more or less be what wdata[0] is in my
suggestion?

This wouldn't work. Some of the EC commands do not take addresses as
arguments. In fact only "RD_EC" (read byte) and "WR_EC" (write byte)
take addresses. All others, BE_EC (burst enable), BD_EC (burst
disable) and QR_EC (query EC) do not take any argument at all.  

Please note that ec_transaction() is *not* an API for reading/writing
a series of bytes from/to EC *memory*. Instead It is an API to write a
command to the EC control port and then read/write a series of bytes
from/to the EC data port.

The reason I did this patch was that I needed a generic way to access
the ACPI EC for my MSI S270 laptop driver. The non-standard EC MSI
builds into its laptops knows a few non-standard commands, besides the
standard commands listed above. These commands are not from the 0x80
range like RD/WR/BE/BD/QR, but from the 0x10 range. The data these
commands take is completely arbitrary, the commands have no notion of
an "address".

> >+{
> >+        if (acpi_ec_poll_mode)
> >+                return acpi_ec_poll_transaction(ec, command, 
> >wdata, wdata_len, rdata, rdata_len);
> >+        else
> >+                return acpi_ec_intr_transaction(ec, command, 
> >wdata, wdata_len, rdata, rdata_len);
> >+}
> >+
> 
> It would be better to use a function pointer instead of
> using if-lese statement which looks not so neat.

Hmm, this is just the way the original acpi_ec_read()/acpi_ec_write()
functions worked. I didn't want to change too much of the logic,
because, honestly, I didn't understand everything in that source
file, such as the full semantics of the "poll" version of the
functions in contrast to the "intr" version.

> > static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
> > {
> >-	if (acpi_ec_poll_mode)
> >-		return acpi_ec_poll_read(ec, address, data);
> >-	else
> >-		return acpi_ec_intr_read(ec, address, data);
> >+        int result;
> >+        u8 d;
> >+        result = acpi_ec_transaction(ec, 
> >ACPI_EC_COMMAND_READ, &address, 1, &d, 1);
> >+        *data = d;
> >+        return result;
> > }
> 
> Due to missing argument: address, you have to pass address in
> argument: wdata. This kind of code style is prone to error.

See above. 

If we'd pass the address seperately we couldn't use
acpi_ec_transaction() to implement acpi_ec_query(), because QR_EC
doesn't take any address argument (wdata_len = 0). 

> > static int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
> > {
> >-	if (acpi_ec_poll_mode)
> >-		return acpi_ec_poll_write(ec, address, data);
> >-	else
> >-		return acpi_ec_intr_write(ec, address, data);
> >+        u8 wdata[2] = { address, data };
> >+        return acpi_ec_transaction(ec, ACPI_EC_COMMAND_WRITE, 
> >wdata, 2, NULL, 0);
> > }
> 
> It would be more clear if there is argument : address.

See above.

> 
> >-static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, 
> >u32 * data)
> >+
> >+static int acpi_ec_poll_transaction(union acpi_ec *ec, u8 command,
> >+                                    const u8 *wdata, unsigned 
> >wdata_len,
> >+                                    u8 *rdata, unsigned rdata_len)
> > {
> > 	acpi_status status = AE_OK;
> > 	int result = 0;
> > 	unsigned long flags = 0;
> > 	u32 glk = 0;
> > 
> >-	ACPI_FUNCTION_TRACE("acpi_ec_read");
> >+	ACPI_FUNCTION_TRACE("acpi_ec_poll_transaction");
> > 
> >-	if (!ec || !data)
> >+	if (!ec || !wdata || !wdata_len || (rdata_len && !rdata))
> > 		return_VALUE(-EINVAL);
> 
> 
> why return -EINVAL if wdata_len == 0?

Got me! This is a bug. This should read:

If (!ec || (wdata_len && !wdata) || (rdata_len && !rdata)) ...

BTW: I noticed that ec.c recieved quite a few cleanups in the
2.6.18-pre kernels. Apparently no logic really changed, but some
tracing has been removed among other minor stuff. My patch doesn't
apply cleanly anymore. 

Shall I prepare an updated patch?

Thanks for reviewing,
        Lennart

-- 
Lennart Poettering; lennart [at] poettering [dot] net
ICQ# 11060553; GPG 0x1A015CC4; http://0pointer.net/lennart/
