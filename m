Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422845AbWJPTKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422845AbWJPTKc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422767AbWJPTKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:10:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:22465 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422853AbWJPTKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:10:30 -0400
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
	configfs
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Greg KH <greg@kroah.com>
Cc: Paul Menage <menage@google.com>, ckrm-tech@lists.sourceforge.net,
       Matt Helsley <matthltc@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061012235127.GA15767@kroah.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	 <20061010203511.GF7911@ca-server1.us.oracle.com>
	 <6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	 <20061010215808.GK7911@ca-server1.us.oracle.com>
	 <1160527799.1674.91.camel@localhost.localdomain>
	 <20061011012851.GR7911@ca-server1.us.oracle.com>
	 <20061011223927.GA29943@kroah.com> <1160609160.6389.80.camel@linuxchandra>
	 <20061012235127.GA15767@kroah.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 16 Oct 2006 12:10:25 -0700
Message-Id: <1161025825.6389.119.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 16:51 -0700, Greg KH wrote:
> On Wed, Oct 11, 2006 at 04:26:00PM -0700, Chandra Seetharaman wrote:
> > On Wed, 2006-10-11 at 15:39 -0700, Greg KH wrote:
> > > On Tue, Oct 10, 2006 at 06:28:51PM -0700, Joel Becker wrote:
> > > > On Tue, Oct 10, 2006 at 05:49:59PM -0700, Matt Helsley wrote:
> > > > > 	We want to be able to export a sequence of small (<< 1 page),
> > > > > homogenous, unstructured (scalar), attributes through configfs using the
> > > > > same file. While this is rather specific, I'd guess it would be a common
> > > > > occurrence.
> > > > 
> > > > 	Pray tell, why?  "One attribute per file" is the mantra here.
> > > > You really should think hard before you break it.  Simple heuristic:
> > > > would you have to parse the buffer?  Then it's wrong.
> > > 
> > > I agree.  You are trying to use configfs for something that it is not
> > > entended to be used for.  If you want to write/read large numbers of
> > > attrbutes like this, use your own filesystem.
> > 
> > I would say it is a "large attribute" not "large numbers of attributes".
> 
> That attribute seems to violate the rule of "only one thing" and needs
> to be parsed.  That does not seem like a good fit for configfs or sysfs.

As pointed by Paul Jackson in a reply, what we are trying to get is a
list of pids, which can be termed as vectors and doesn't need serious
parsing, but simply separating the items in the list by a '\n'.

What I was trying to do in the patches is to remove some code (which
maintains its own buffer) by an existing mechanism, seq_file. 

As Andrew pointed in one of the email, my patch set reduces the number
of lines of code in configfs also.

You do not think that is a good idea ?

> 
> 
> > > configfs has the same "one value per file" rule that sysfs has.  And
> > > because your userspace model doesn't fit that, don't try to change
> > > configfs here.
> > > 
> > > What happened to your old ckrmfs?  I thought you were handling all of
> > > this in that.
> > 
> > We decided to use an existing infrastructure instead of having our own
> > file system.
> > 
> > configfs is a perfect fit for us, except the size limitation.
> 
> Then it's not a perfect fit, sorry, as you are trying to get it to do
> things it is not supposed to, or designed to, do.
>
> > BTW, it it not just CKRM/RG, Paul Menage as recently extracted the
> > processes aggregation from cpuset to have an independent infrastructure
> > (http://marc.theaimsgroup.com/?l=ckrm-tech&m=116006307018720&w=2), which
> > has its own file system. I was advocating him to use configfs. But, he
> > also has this issue/limitation. 
> 
> That's one reason it is so easy to just write your own filesystem then.
> What is it these days, less than 200 lines of code?  I bet you can even
> condence more things to make it 100 lines if you really try.  That seems
> much more sane than trying to bend configfs into something different.

I thought the mantra is "Use existing infrastructure, instead of writing
your own".

> 
> Why are people so opposed to creating their own filesystems?

I do not think we were/are. As you pointed we did have our own file
system. And as I mentioned, we moved to configfs mainly to reduce code
size and to start using the existing infrastructure.

Same is true even for the (cpuset extracted) patch set submitted by Paul
Menage. It does have its own file system. I was advocating him to use
configfs for the same reason (to use existing interface).

> thanks,
> 
> greg k-h
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


