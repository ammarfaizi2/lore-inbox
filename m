Return-Path: <linux-kernel-owner+w=401wt.eu-S1030277AbWL3FQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWL3FQs (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 00:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWL3FQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 00:16:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46526 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030271AbWL3FQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 00:16:47 -0500
Message-ID: <4595F630.70705@osdl.org>
Date: Fri, 29 Dec 2006 21:16:32 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Keiichi KII <k-keiichi@bx.jp.nec.com>
CC: mpm@selenic.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH -mm take2 3/5] add interface for netconsole using
 sysfs
References: <4590AE00.5040102@bx.jp.nec.com> <4590B365.8010707@bx.jp.nec.com>
In-Reply-To: <4590B365.8010707@bx.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keiichi KII wrote:
> From: Keiichi KII <k-keiichi@bx.jp.nec.com>
>
> This patch contains the following changes.
>
> create a sysfs entry for netconsole in /sys/class/misc.
> This entry has elements related to netconsole as follows.
> You can change configuration of netconsole(writable attributes such as IP
> address, port number and so on) and check current configuration of netconsole.
>
> -+- /sys/class/misc/
>  |-+- netconsole/
>    |-+- port1/
>    | |--- id          [r--r--r--]  unique port id
>    | |--- remove      [-w-------]  if you write something to "remove",
>    | |                             this port is removed.
>   
IMHO this kind of "magic side effect" is a misuse of sysfs. and would
make proper locking
impossible. How do you deal with the dangling reference to the
netconsole object?
f= open (... netconsole/port1/remove")
write(f, "", 1)
sleep(2)
write(f, "", 1) .... this probably would crash...


Maybe having a state variable/sysfs file so you could setup the port and
turn it on/off with write.
>    | |--- dev_name    [r--r--r--]  network interface name
>   

Please don't use dev_name, instead use a a symlink. You see if the
device is renamed,
the dev_name will be wrong, but the symlink to the net_device kobject
should be okay.
>    | |--- local_ip    [rw-r--r--]  source IP to use, writable
>    | |--- local_port  [rw-r--r--]  source port number for UDP packets, writable
>    | |--- local_mac   [r--r--r--]  source MAC address
>    | |--- remote_ip   [rw-r--r--]  port number for logging agent, writable
>    | |--- remote_port [rw-r--r--]  IP address for logging agent, writable
>    | ---- remote_mac  [rw-r--r--]  MAC address for logging agent, writable
>    |--- port2/
>    |--- port3/
>    ...
>
> Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
> Signed-off-by: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
>   

