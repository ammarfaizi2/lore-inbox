Return-Path: <linux-kernel-owner+w=401wt.eu-S932243AbXAIRFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbXAIRFz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbXAIRFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:05:55 -0500
Received: from tzec.mtu.ru ([195.34.34.228]:2760 "EHLO tzec.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932247AbXAIRFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:05:54 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: .version keeps being updated
To: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org
Date: Tue, 09 Jan 2007 20:05:49 +0300
References: <20070109102057.c684cc78.khali@linux-fr.org>
User-Agent: KNode/0.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20070109170550.AFEF460C343@tzec.mtu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:

> Hi all,
> 
> Since 2.6.20-rc1 or so, running "make" always builds a new kernel with
> an incremented version number, whether there has actually been any
> change done to the code or configuration or not. This increases the
> build time quite a bit.
> 
> I've tracked it down to include/linux/compile.h always being updated,
> and this is because .version is updated. I couldn't find what is
> causing .version to be updated each time though. Can anybody help
> there? Was this change made on purpose or is this a bug which we should
> fix? 

I have been bitten by this as well; I have tracked it down to defining
CONFIG_KALLSYMS:

define rule_vmlinux__
        :
        $(if $(CONFIG_KALLSYMS),,+$(call cmd,vmlinux_version))

quiet_cmd_vmlinux_version = GEN     .version
      cmd_vmlinux_version = set -e;                     \
        if [ ! -r .version ]; then                      \
          rm -f .version;                               \
          echo 1 >.version;                             \
        else                                            \
          mv .version .old_version;                     \
          expr 0$$(cat .old_version) + 1 >.version;     \
        fi;                                             \
        $(MAKE) $(build)=init


 Pondering about it, this may be a feature not a bug. Let's assume you have
changed a single function name anywhere - you need to rebuild kallsyms
(ergo vmlinux) for that.

OTOH I do not know if kallsyms include also symbols from modules; if no,
this is indeed a bug.

-andrey

