Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937910AbWLGBYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937910AbWLGBYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937915AbWLGBYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:24:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:28762 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937910AbWLGBYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:24:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=FE9on195kFKDZaaCmm9vLd4LWKUCi0pZA9hzF/BkVXN/2OY+26eR7PX0D4h9OTT9QzGPnFGswuvnUJnsD7G+7nlhSaQC1LGo3zhNFi8v0XMU2n9tqW/9B2TIKNvskewIX/h1MSkPcpmDF5LaXLLDEvpM8F32gu4pZQG1ZdgGAGQ=
Message-ID: <45776D4F.6070806@gmail.com>
Date: Thu, 07 Dec 2006 02:24:08 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Eric Fox <efox@einsteinindustries.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Char: isicom, fix card locking
References: <1165451982-AXRLGS2HCEVCUY1@www.vabmail.com>
In-Reply-To: <1165451982-AXRLGS2HCEVCUY1@www.vabmail.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Fox wrote:
> Patch works if I disable SMP in kernel.

Aha, and it didn't work without the patch with SMP disabled?

> strace setserial -g /dev/ttyM0
> execve("/bin/setserial", ["setserial", "-g", "/dev/ttyM0"], [/* 17 vars
> */]) = 0
> uname({sys="Linux", node="dialin-0.vab.com", ...}) = 0
> brk(0)                                  = 0x804d000
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
> directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=19713, ...}) = 0
> old_mmap(NULL, 19713, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f58000
> close(3)                                = 0
> open("/lib/tls/libc.so.6", O_RDONLY)    = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\36"..., 512) =
> 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=1454802, ...}) = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0xb7f57000
> old_mmap(0x39d000, 1223900, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
> 3, 0) = 0x39d000
> old_mmap(0x4c2000, 16384, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x124000) = 0x4c2000
> old_mmap(0x4c6000, 7388, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4c6000
> close(3)                                = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
> 0) = 0xb7f56000
> mprotect(0x4c2000, 4096, PROT_READ)     = 0
> mprotect(0x399000, 4096, PROT_READ)     = 0
> set_thread_area({entry_number:-1 -> 6, base_addr:0xb7f566c0, limit:1048575,
> seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
> seg_not_present:0, 0munmap(0xb7f58000, 19713)               = 0


> open("/dev/ttyM0", O_RDWR|O_NONBLOCK)   = 3
> ioctl(3, TIOCGSERIAL, 0xbf81c280)       = 0

In one of these two there should lie the problem in SMP mode. The latter is OK
(no locking), but the former -- hmm, it gets stuck: I guess, we have a recursive
locking example here (I can see one of many in the driver now):
isicom_open()
{
...
isicom_setup_port()
...
}

isicom_setup_port()
{
...
        spin_lock_irqsave(&card->card_lock, flags);
...
        isicom_config_port();
...
        spin_unlock_irqrestore(&card->card_lock, flags);
}

isicom_config_port()
{
...
	lock_card()
...
	unlock_card()
...
}

lock_card()
{
...
	spin_lock_irqsave(&card->card_lock, card->flags);
...
}

unlock_card()
{
	spin_unlock_irqrestore(&card->card_lock, card->flags);
}

Going to fix these.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
