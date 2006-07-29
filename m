Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWG2Oqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWG2Oqa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 10:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWG2Oqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 10:46:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:35557 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751364AbWG2Oq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 10:46:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=MnczqyJREdrD2F58mPB3FH8/WG6EOAsIqM7GHx0HE/dccyrCdSUEXCdB2Llqs3yBb6HOLM4PzaBCK+sXJ8iLfKC0TxsUGNP5tiw1C05dcMhAM2JV9lD7OC+2rvBu+HArK0HDAFCAuZTqlQ+0zkski9X+X2CUf0rpYs+CglsC0gs=
Date: Sat, 29 Jul 2006 16:45:28 +0200
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via sata oops on init
Message-ID: <20060729144528.GD28712@leiferikson.dystopia.lan>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060728233950.GD3217@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060728233950.GD3217@redhat.com>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 28, 2006 at 07:39:50PM -0400, Dave Jones wrote:
> 2.6.18-rc2-git6
> 
> BUG: unable to handle kernel NULL pointer dereference at 00000000
> EIP is at make_class_name+0x27
> eax: 00000000 ebx: ffffffff ecx: ffffffff edx: 00000009
> esi: f8d16cc2 edi: 00000000 ebp: f7fa9d3c esp: f7fa9d2c
> 
> Call Trace:
> class_device_del+0xac
> class_device_unregister
> scsi_remove_host
> ata_host_remove
> ata_device_add

I think the problem lays in scsi/libata-core.c:5423 in
torvalds/linux-2.6 v2.6.18-rc2-g6482132, stating:

[...]
struct ata_host_set *host_set = kzalloc(...);
[...]

Initialization of some structure members, but not ports(!)

for (...) {
	struct ata_port *ap;

	ap = ata_host_add(ent, host_set, i);
	if (!ap)
		goto err_out;
	
	host_set->ports[i] = ap;

err_out:
	for (i = 0; i < count; i++) {
		ata_host_remove(host_set->ports[i], 1);
[...]

ata_device_add fails, calls ata_host_remove with pointers to unitialized
memory.

Hannes
