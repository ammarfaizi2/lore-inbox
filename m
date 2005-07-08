Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVGHMUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVGHMUr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 08:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVGHMUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 08:20:40 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:54950 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262593AbVGHMTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 08:19:53 -0400
Message-ID: <42CE6FF9.4040505@jp.fujitsu.com>
Date: Fri, 08 Jul 2005 21:22:17 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       Linas Vepstas <linas@austin.ibm.com>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 2.6.13-rc1 01/10] IOCHK interface for I/O error handling/detecting
References: <42CB63B2.6000505@jp.fujitsu.com>	 <20050707184102.GC14726@kroah.com> <1120775239.31924.262.camel@gaston>
In-Reply-To: <1120775239.31924.262.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Thu, 2005-07-07 at 11:41 -0700, Greg KH wrote:
>>How about the issue of tying this into the other pci error reporting
>>infrastructure that is being worked on?
> 
> The other infrastructure is for asynchronous reporting and recovery.
> We still need synchronous detection & reporting. So this is a bit
> different.

The interesting point is that it seems that both could use for reporting.

> However, it would be nice if Hidetoshi's work could be adapted a bit so
> that 1) naming is a bit more consistent with the other stuff (pcierr_*
> maybe) and 2) the error "token" is the same. The later is especially
> important if we start adding ways to query the error token to know what
> the error precisely was etc... There is no reason to have 2 different
> ways of representing error details.

The naming doesn't really matter. iochk_* is just my preference.
However it would be worth a try to move generic codes from iomap.*
(historical home) to pci.* and rename iochk_* to pcierr_*.

Well, I'd like to use this opportunity to sort out my thoughts...

Now iochk_read() returns a boolean value, whether there was a error
or not. Of course I agree that it would be more useful if it can return
the detail of the error.

A quick solution is return "token" instead of boolean value 1.
-extern int iochk_read(iocookie *cookie);
+extern token iochk_read(iocookie *cookie);

The token should be a pointer or a bitmask having proper flags, not 0.
So this still work:
   if(iochk_read(cookie)) return -EIO;
and now this will also work:
   if((token=iochk_read(cookie))!=0){
      switch(severity(token)) {
        ...
   }}

The error "token", tentatively named "pci_error_token" in document
you posted, is now temporarily defined in recent Linas's patch using
other alias:
  enum pci_channel_state {
	pci_channel_io_normal = 0, /* I/O channel is in normal state */
	pci_channel_io_frozen = 1, /* I/O to channel is blocked */
	pci_channel_io_perm_failure, /* pci card is dead */
  };
Of course this will be not enough in near future.

I have already agree with what few month ago you said:
> The token should be an opaque type with accessors. You could define a
> pci_error_get_severity(token) to return the severity. The idea is to
> define accessors which return an error when the data requested isn't
> present in the error info. The actual content of the token is to be
> defined. I was thinking about a type plus a union. I was hoping Seto
> could provide something here ...

For example:
  /* offsets */
  enum {
	pcierr_io_frozen = 0, 	/* I/O to channel is blocked */
	pcierr_io_perm_failure, /* pci card is dead */
	pcierr_severity_valid,  /* 1:valid */
	pcierr_severity,     	/* 0:non-fatal 1:fatal */
  };

  #define pcierr_perm_failure(token) \
	test_bit(pcierr_io_perm_failure, token)

  int pcierr_get_severity(token)
  {
	if(test_bit(pcierr_severity_valid, token)) {
	  return test_bit(pcierr_severity, token);
	}
	return -1;
  }

Objections?
Are there any better place to put a group of codes like above than
include/linux/pci.h?

By the way, if token says frozen but not perm_failure, is it mean
"recovery processing now"? Are there any special state which
synchronous detection have to report?

Thanks,
H.Seto

