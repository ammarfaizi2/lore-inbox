Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbSJUEUT>; Mon, 21 Oct 2002 00:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264733AbSJUEUS>; Mon, 21 Oct 2002 00:20:18 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:51946 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264730AbSJUETP>; Mon, 21 Oct 2002 00:19:15 -0400
Date: Sun, 20 Oct 2002 21:26:36 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.44: problemn when shutting down, drivers/base/power.c and the global_device_list
Message-ID: <20021021042636.GB1534@beaverton.ibm.com>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
References: <20021019153417.GA567@middle.of.nowhere> <Pine.LNX.4.44.0210201117080.963-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210201117080.963-100000@cherise.pdx.osdl.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel [mochel@osdl.org] wrote:
> ->detect() calls ncr_attach() at least once for each host adapter, which 
> calls scsi_register(), which adds the host to the internal list of host 
> adapters. Fine, but once control finally returns to scsi_register_host(), 
> it will try to do scsi_register() if the low-level driver "failed to 
> register a driver."

This was left in during the cleanup and probably should be removed as I
cannot find a driver that needs this and it most likely is not a good
idea if a driver detect routine did not add it in. I will see if I can
get some history on why it was needed.

> (Sprinkle with scsi_unregister_host()s in the host 
> driver code, and generic code, and you have successfully created a very 
> convoluted code path.)
> 
> AFAICT, scsi_register() doesn't successfully check for duplicate names, 
> and multiple instances of the host aren't detected. And the list 
> manipulation itself is fishy at best. 

scsi_register doesn't need to check for duplicate names. A call to
scsi_register adds a instance of a host and scsi_unregister removes one.
Each host on the list has a unique instance number (i.e scsi(n)).

scsi_register_host adds an scsi driver to the the scsi sub-system and
scsi_unregister_host removes one.

> 
> scsi_register_host() then loops through the hosts, and registers all the 
> ones that this driver added. (Q: why is that function constantly looping 
> through all the scsi hosts just to operate on the one passed in?).

The constant looping is created by there only being one list and the
fact the the upper level drivers expect certain behaviors on the calling
of init, attach, finish.

> 
> If there are multiple instances of the same driver on the list, then very
> interesting things will happen. The device will be inserted into the 
> lists, but directory creation will fail, which will cause the device to be 
> removed from the lists its on, which is bad juju. scsi_register_host() is 
> not checking the return of device_register() either, and unconditionally 
> calling scan_scsis(). 

ok I will add a return check on device_register. I will also add a check
for the driver already being registered. There was an old check to see
if the list pointer was non-null, but this is probably not the best if
the driver was passing in a non-static.

-andmike
--
Michael Anderson
andmike@us.ibm.com

