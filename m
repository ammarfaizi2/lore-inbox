Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbUAZAmX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 19:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265399AbUAZAmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 19:42:23 -0500
Received: from CPE0020afeeb1ac-CM014250013274.cpe.net.cable.rogers.com ([24.114.21.153]:13071
	"EHLO hoby.coplanar.net") by vger.kernel.org with ESMTP
	id S265379AbUAZAmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 19:42:21 -0500
Message-ID: <40146269.8060606@coplanar.net>
Date: Sun, 25 Jan 2004 19:42:17 -0500
From: Jeremy Jackson <jerj@coplanar.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 IDE hang on boot with two single-channel controllers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

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

