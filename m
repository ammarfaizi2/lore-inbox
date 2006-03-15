Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751669AbWCOWF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbWCOWF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWCOWF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:05:59 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:21439 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751662AbWCOWF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:05:58 -0500
Message-ID: <44188FBC.3090603@us.ibm.com>
Date: Wed, 15 Mar 2006 16:05:48 -0600
From: Anthony Liguori <aliguori@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060309)
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Dan Hecht <dhecht@vmware.com>,
       Dan Arai <arai@vmware.com>, Anne Holler <anne@vmware.com>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>
Subject: Re: [RFC, PATCH 5/24] i386 Vmi code patching
References: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>
In-Reply-To: <200603131802.k2DI2nv8005665@zach-dev.vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:
> +void __init vmi_init(void)
> +{
> +	int romsize;
> +
> +	/*
> +	 * Setup optional callback functions if we found the VMI ROM
> +	 */
> +	if (hypervisor_found) {
> +		romsize = vmi_rom->romLength * 512;
> +		if (VROMFunc(vmi_rom, VMI_CALL_Init)) {
> +			printk(KERN_WARNING "VMI ROM failed to initialize\n");
> +			hypervisor_found = 0;
> +		} else {
> +			memcpy(&__VMI_START, (char *)vmi_rom, romsize);
> +			scan_builtin_annotations();
> +		}
> +	}
> +	if (!vmi_rom) 
> +		printk(KERN_WARNING "VMI ROM not found"
> +		       " - falling back to native mode\n");
> +	else if (!hypervisor_found)
> +		printk(KERN_WARNING "VMI ROM version mismatch "
> +		       "(kernel requires version >= %d.%d) "
> +		       " - falling back to native mode\n",
> +		       VMI_API_REV_MAJOR, MIN_VMI_API_REV_MINOR);
> +}
>   
Minor nitpick.

The error logic here is somewhat confusing.  If a VMI_CALL_Init results 
in a failure, you end up with:

  VMI ROM failed to initialize
  VMI ROM version mismatch (kernel requires version >= 13.0) - falling 
back to native mode

The later error is misleading as the version may actually match.  The 
nesting here probably could be simplified to.

Regards,

Anthony Liguori

