Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265043AbUFMLU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265043AbUFMLU5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 07:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265044AbUFMLU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 07:20:56 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:21121 "EHLO cloud.ucw.cz")
	by vger.kernel.org with ESMTP id S265043AbUFMLUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 07:20:50 -0400
Date: Sun, 13 Jun 2004 13:20:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tisheng Chen <tishengchen@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Solution to the "1802: Unauthorized network card" problem in recent thinkpad systems
Message-ID: <20040613112051.GA1416@ucw.cz>
References: <20040613073950.21346.qmail@web90101.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040613073950.21346.qmail@web90101.mail.scd.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 12:39:50AM -0700, Tisheng Chen wrote:

> In recent IBM thinkpad systems, there is a limit to
> allowed MiniPCI wireless cards. When an unauthorized
> card is plugged in, the system doesn't boot and
> halt with an error message like:
> 
> ERROR
> 1802: Unauthorized network card is plugged in
> Power off and remove the miniPCI network card.

[snip]

> The other way is unbelievably simple. There is a byte
> in CMOS which controls whether an "unauthorized" card
> is allowed or not. That's 0x6a, actually only
> the bit 0x80. The program to unlock the authorization
> mechanism is like (asm):
> 
> MOV     DX,0070
> MOV     AL,6A
> OUT     DX,AL
> MOV     DX,0071
> IN      AL,DX
> OR      AL,80
> OUT     DX,AL
> MOV     AX,4C00
> INT     21
> 
> The program can be downloaded from:
>   http://jcnp.pku.edu.cn/~shadow/1802/no-1802.com
> To use this program, you need to boot to DOS.
> 
> The CMOS solution is safe, but I'm not sure that it
> works for all recent thinkpads and all cards. The BIOS
> crack sure does, however it is difficult
> and dangerous.

Well, here is a version for Linux:

------------------------------------------------------------

#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(void)
{
	int fd;
	unsigned char data;

	printf("Disabling WiFi whitelist check.\n");
	fd = open("/dev/nvram", O_RDWR);
	lseek(fd, 0x6a, SEEK_SET);
	read(fd, &data, 1);
	printf("CMOS address 0x6a: %02x->", data);
	data &= ~0x80;
	printf("%02x\n", data);
	lseek(fd, 0x6a, SEEK_SET);
	write(fd, &data, 1);
	close(fd);
	printf("Done.\n");
}

------------------------------------------------------------

I've tried it on my ThinkPad X31, but it doesn't work at all. The CMOS
has a value 0xfa at the offset 0x6a, so the most upper bit is already
set.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
