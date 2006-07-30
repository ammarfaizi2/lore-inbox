Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWG3KOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWG3KOO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 06:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWG3KOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 06:14:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:58343 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932096AbWG3KOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 06:14:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kGgGn99NGy5dMUknyhloc2vtZYl3lf9bNn/Ql9kmvyH3NixQ82eITDlLWtasGVs8BZg80stL7V440JKWhc9SAdWjlOBv8oIfa7CHMHFSr7wkLaKw4+aZPddGtQGOZerm57F5acpy+sIJNWm/CYrh8rB0uSAw3K1DBsYd+a/967k=
Message-ID: <41840b750607300314t3280fd04ne17bb663c385fd6b@mail.gmail.com>
Date: Sun, 30 Jul 2006 13:14:10 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: Generic battery interface
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org,
       "Greg KH" <greg@kroah.com>
In-Reply-To: <20060730091848.GC3801@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz>
	 <20060728134307.GD29217@suse.cz> <20060730091848.GC3801@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/06, Pavel Machek <pavel@suse.cz> wrote:
> OTOH some applications just want more frequent polling than
> others. Shem's "first update after N msec" solution looks most
> flexible here.

Actually my solution was "any update but no sooner than N msecs". So
you might be getting a readout that's N-1 msecs old, which was
meanwhile cached by the driver. If you care about that, you need to
use interleave those polls with msleep()s; see my recent detailed
post. You'll still doing at most one msleep() per fetched readout,
regardless of how frequently the driver provides them.

Alternatively, we can add an extra parameter to that new
syscall/ioctl: "block until the time is T+N and you have a refresh
that was received from the hardware at time T+M, whichever is later"
(where T is the current time and N>M).

That's semantically equivalent to an msleep(M) followed by the
original delayed_update(N-M),  but will save one timer interrupt per
iteration in some cases (e.g., an event-based hardware data source).

  Shem
