Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751462AbWJEOaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWJEOaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 10:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWJEOaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 10:30:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:64980 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751462AbWJEOaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 10:30:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZWQ4RJAR2YCDiNDhOFthmVtxchRW+ut7i0jc4b6ApcQH9LGHsEhhdsSyi31NWhQGTVXu8ygySHB1n90ytopv4zgSgAnlrFVRdUfr2B8XoHrayfZAs8+rXGKtndmMV/FOBFtZ9ej4H/4eiPB00qRnQu+P5gH6NCx8R6785N0Q+C4=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: "Alex Owen" <r.alex.owen@gmail.com>
Subject: Re: forcedeth net driver: reverse mac address after pxe boot
Date: Thu, 5 Oct 2006 16:28:40 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, c-d.hailfinger.kernel.2004@gmx.net,
       aabdulla@nvidia.com
References: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com>
In-Reply-To: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051628.40247.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 October 2006 18:19, Alex Owen wrote:
> I an issue with the forcedeth driver when used after the BIOS PXE routines.
> When booting directly from disk the ethernet MAC address is normal.
> eg: 00:16:17:xx:yy:zz
> But is the BIOS PXE boot stack loads pxelinux which then boots the
> local disk, or if pxelinux loads a kernel/initrd, then the MAC address
> detected by the forcedeth linux driver is reversed.
> eg zz:yy:xx:17:16:00
> 
> This is obviously causes me a problem with automated installs started
> via PXE boot as the installed cannot DHCP as the MAC address is wrong.
> 
> I have read some of the bug reports and LKML threads on WOL and
> forcedeth and I have looked at the code of the driver... most closely
> forcedeth v57 as per comment #22 of
> http://bugzilla.kernel.org/show_bug.cgi?id=6604
> 
> My understanding of the code is that the driver determines the cards
> MAC address by reading from registers in the ethernet controller, but
> that for reasons best known to nvidia this  address backwards and so
> the driver "fixes" this by itself reversing the read values and
> writing them back to the controller.
> 
> This normally works ok and there has been some work to put the old
> "wrong" MAC address back at close down to get WOL to work to.
> 
> Enter PXE... Booting from PXE (in BIOS) seems to "fixup" the "wrong"
> MAC address so when the driver determines the cards MAC address by
> reading from registers in the ethernet controller then MAC address
> there is now CORRECT. The driver however assumes it is reversed and in
> trying to "fix" the MAC address is infact writes back the
> revesed/broken MAC back to the controller.
> 
> The obvious fix for this is to try and read the MAC address from the
> canonical location... ie where is the source of the address writen
> into the controlers registers at power on? But do we know where that
> may be?
> 
> The other solution would be unconditionally reset the controler to
> it's power on state then use the current logic? can we reset the
> controller via software?
> There does seem to be an nv_mac_reset function... and this does seem
> to be called if the card has a capability DEV_HAS_POWER_CONTROL but it
> is called in nv_open() while the MAC is read in nv_probe().
> 
> Perhaps we need to unconditionally run nv_mac_reset just before
> reading the MAC in nv_probe() ?
> 
> Anyway I hope that someone who knows kernel internals and this driver
> inparticular feels the urge to look at this!

Also MAC addresses cannot be arbitrary. If nothing else would work,
we can add OUI numbers (3 most significant bytes of MAC)
of known suppliers of nvidia eth and check whether they are
in lower bytes or in higher ones.
--
vda
