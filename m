Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbUAZP54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 10:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUAZP5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 10:57:49 -0500
Received: from CPE0020afeeb1ac-CM014250013274.cpe.net.cable.rogers.com ([24.114.21.153]:19728
	"EHLO hoby.coplanar.net") by vger.kernel.org with ESMTP
	id S265729AbUAZP5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 10:57:40 -0500
Message-ID: <401538C6.5030609@coplanar.net>
Date: Mon, 26 Jan 2004 10:56:54 -0500
From: Jeremy Jackson <jerj@coplanar.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Torben Mathiasen <torben.mathiasen@hp.com>, linux-kernel@vger.kernel.org,
       linux-ide <linux-ide@vger.kernel.org>
Subject: Re: 2.4.23 IDE hang on boot with two single-channel controllers
Content-Type: multipart/mixed;
 boundary="------------070202000807000605080407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070202000807000605080407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

(watch crossposting when replying all)

I'm hoping to reach the maintainer of the Linux IDE driver for the 
Compaq TriFlex controller.  I have a problem with this driver when used 
with a Compaq Armada 7730MT while docked in the base station.

The driver appears to only support one triflex controller, due to a 
missing check (that other chipset drivers have) that should prevent it 
from registering a /proc interface more than once.  The result is that 
it hangs on boot in proc_ide_create() in an infinite loop.

triflex.c:

static unsigned int __init init_chipset_triflex(struct pci_dev *dev,
                 const char *name)
{
#ifdef CONFIG_PROC_FS
         ide_pci_register_host_proc(&triflex_proc);
#endif
         return 0;
}

It also appears that triflex_get_info() doesn't support more that one 
controller.

I won't go into more detail until I can establish who might care :)

Regards,

Jeremy Jackson

--------------070202000807000605080407
Content-Type: message/rfc822;
 name="2.4.23 IDE hang on boot with two single-channel controllers"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.23 IDE hang on boot with two single-channel controllers"

Return-Path: <linux-ide-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [67.72.78.212])
	by hoby.coplanar.net (8.12.3/8.12.3/Debian-6.6) with ESMTP id i0QEkYmC022073
	for <jerj@coplanar.net>; Mon, 26 Jan 2004 09:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264420AbUAZOo5 (ORCPT <rfc822;jerj@coplanar.net>);
	Mon, 26 Jan 2004 09:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUAZOo5
	(ORCPT <rfc822;linux-ide-outgoing>); Mon, 26 Jan 2004 09:44:57 -0500
Received: from CPE0020afeeb1ac-CM014250013274.cpe.net.cable.rogers.com ([24.114.21.153]:7440
	"EHLO hoby.coplanar.net") by vger.kernel.org with ESMTP
	id S263771AbUAZOoy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2004 09:44:54 -0500
Received: from coplanar.net (CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com [24.112.162.124])
	(authenticated bits=0)
	by hoby.coplanar.net (8.12.3/8.12.3/Debian-6.6) with ESMTP id i0QEinmD022070
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 26 Jan 2004 09:44:53 -0500
Message-ID: <401527E1.6040108@coplanar.net>
Date: Mon, 26 Jan 2004 09:44:49 -0500
From: Jeremy Jackson <jerj@coplanar.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
Subject: 2.4.23 IDE hang on boot with two single-channel controllers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org

Hi All,

Already posted this to linux-kernel.

kdb shows proc_ide_create() stuck in a loop when booting on a Compaq 
Armada 7730MT while attached to the docking station.

This is a unique IDE hardware setup.  Channel ide0's controller is in 
the laptop, while ide1 is a separate controller (pci device) in the 
docking station and is not always present.

This seems to be triggering a bug in ide-proc.c:

void proc_ide_create(void)
{
#ifdef CONFIG_BLK_DEV_IDEPCI
         ide_pci_host_proc_t *p = ide_pci_host_proc_list;
#endif /* CONFIG_BLK_DEV_IDEPCI */

         proc_ide_root = proc_mkdir("ide", 0);
         if (!proc_ide_root) return;

         create_proc_ide_interfaces();

         create_proc_read_entry("drivers", 0, proc_ide_root,
                                 proc_ide_read_drivers, NULL);

#ifdef CONFIG_BLK_DEV_IDEPCI
         while (p != NULL)  <------------------- INFINITE LOOP HERE
         {
                 if (p->name != NULL && p->set == 1 && p->get_info != NULL)
                 {
                         p->parent = proc_ide_root;
                         create_proc_info_entry(p->name, 0, p->parent, 
p->get_info);
                         p->set = 2;
                 }
                 p = p->next;
         }
#endif /* CONFIG_BLK_DEV_IDEPCI */
}

I'm not sure if the problem is in the loop or bad data being setup 
before it starts.

Assistance fixing it would be appreciated.

Regards,

Jeremy Jackson

-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--------------070202000807000605080407--

