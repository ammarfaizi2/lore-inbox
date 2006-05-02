Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWEBTAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWEBTAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWEBTAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:00:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:22579 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964968AbWEBTAc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:00:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uDycBk3THbmUPfio63CKcnIwoaTsjVaIvy/iYe8YSBkZXI2GBgf7I+GvqKpebEuaKVhL+Xlm/ihqJHp2zDcITsqkwefCHsAeYyUxP4sk1pyoz8nvGYIC1+1CHZgkNDppuqBysgNpBo2R5YldulpApHZ0tDfH1eRL+XzIregpWbU=
Message-ID: <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com>
Date: Tue, 2 May 2006 15:00:29 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, airlied@linux.ie, pjones@redhat.com,
       akpm@osdl.org
In-Reply-To: <1146594457.32045.91.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>
	 <44578C92.1070403@linux.intel.com>
	 <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
	 <44579028.1020201@linux.intel.com>
	 <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com>
	 <1146594457.32045.91.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> you're very selective in what you read and only think about X.
> There's many other reasons to enable/disable devices post boot.
> Having a driver just to call pci_enable_device() is silly; and
> there are various scenarios you may want. Userland suspend/resume is
> only one of those, posting video cards is one, chip health monitoring is
> one, etc etc etc. Don't let your lack of imagination ruin things.

Allowing user space control of a device without a mechanism to assign
ownership of the device is a very bad idea. There is no way for one
user space program to tell if another is messing with the device.
There has to be a mechanism like opening the device to indicate which
process owns the device and is allowed to set their state into it (for
states that can conflict, enabling the device is definitely a state
that can conflict).

This attribute will also cause problem with existing drivers. Almost
every driver in the kernel will GPF if you disable the hardware on it
while the driver is loaded and active.  This problem has been the
result of numerous OOPses when X decides to disable hardware that
fbdev is using. I also can not see how user space suspend/resume can
disable PCI hardware without coordinating with an active device
driver.

The rule needs to be that if you want to use a device it has to have a
driver. Anything else results in chaos. It doesn't matter if these
drivers have a tiny API, their purpose is to control ownership of the
hardware.

You may call this silly but it is a real pain to spend hours debugging
code only to discover that it failed because some other app unknown to
you altered the state of the hardware while you were using it.

--
Jon Smirl
jonsmirl@gmail.com
