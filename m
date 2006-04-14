Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbWDNFRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWDNFRE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 01:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbWDNFRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 01:17:04 -0400
Received: from wproxy.gmail.com ([64.233.184.230]:42442 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965099AbWDNFRD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 01:17:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WZcKrnhRjMaZy8Rf6IznZlHpnBWD3YhHs41Lf4L5g5hRC148JJVNsfGB/nxG4jJ+7FtypvF4SEADbQFa1gp1R0yDyuvGXkpriJSubR/ICn1S0/Tgb3EwRkXpLwzMD2CFOq1ldWH1h59mB7JuuNy7bOXjYRqIP3yZdBGycEEmAN8=
Message-ID: <3b8510d80604132217h4f889b4dved183444559cc3ba@mail.gmail.com>
Date: Fri, 14 Apr 2006 10:47:02 +0530
From: "Thayumanavar Sachithanantham" <thayumk@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: modprobe bug for aliases with regular expressions
Cc: "Rusty Russell" <rusty@rustcorp.com.au>, kay.sievers@vrfy.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060413233518.GA7597@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060413233518.GA7597@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/06, Greg KH <greg@kroah.com> wrote:
> Recently it's been pointed out to me that the modprobe functionality
> with aliases doesn't quite work properly for some USB modules.
> Specifically, the usb-storage driver has a lot of aliases with regular
> expressions for the bcd ranges.  Here's an example of it failing with a
> real device:
>
> $ modprobe -n -v --first-time usb:v054Cp0010d0410dc00dsc00dp00ic08iscFFip01
> FATAL: Module usb:v054Cp0010d0410dc00dsc00dp00ic08iscFFip01 not found.
>
> yet if we change the bcd range by replacing the first 0 with a 1 it
> somehow works:
>
> $ modprobe -n -v --first-time usb:v054Cp0010d0400dc00dsc00dp00ic08iscFFip01
> insmod /lib/modules/2.6.17-rc1-gkh/kernel/drivers/usb/storage/libusual.ko
>
> (yet this isn't a solution as the device does not have a 1 in that
> position...)

      It's because in modprobe.c, in the read_config_file , in the
wildcard , the "-" (hyphen) is turned into underscore (_) causing the
fnmatch not to match the first RE.
  a quick change to check this issue is
following change in read_config_file function of modprobe.c should fix it.
                if (strcmp(cmd, "alias") == 0) {
                        char *wildcard
                                = strsep_skipspace(&ptr, "\t ");
                        char *realname
                                = strsep_skipspace(&ptr, "\t ");


S.Thayumanavar
