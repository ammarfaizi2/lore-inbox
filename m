Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261789AbSJDOJP>; Fri, 4 Oct 2002 10:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261790AbSJDOJP>; Fri, 4 Oct 2002 10:09:15 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:41746 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261789AbSJDOJN>; Fri, 4 Oct 2002 10:09:13 -0400
Date: Fri, 4 Oct 2002 15:14:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
Message-ID: <20021004151442.B30635@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <OF25D731E3.0E245DDC-ON85256C47.00645AA7@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF25D731E3.0E245DDC-ON85256C47.00645AA7@pok.ibm.com>; from peloquin@us.ibm.com on Thu, Oct 03, 2002 at 01:59:47PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +#define SetPluginID(oem, type, id) ((oem << 16) | (type << 12) | id)
> >> +#define GetPluginOEM(pluginid) (pluginid >> 16)
> >> +#define GetPluginType(pluginid) ((pluginid >> 12) & 0xf)
> >> +#define GetPluginID(pluginid) (pluginid & 0xfff)
> 
> > What is the prupose of OEM IDs?
> 
> To allow unique identification of plugins. If you wrote
> plugin, you might give it an ID of 1. Someone else
> may do the same thing. However, by letting you add
> something specific which identifies you (i.e. like
> your initials), then possibility of collisions is
> reduced.

Please stop using magic numbers in the kernel _at all_.  The only
sensible thing against collision is proper naming, i.e. strings.

> 
> >> +struct evms_plugin_header {
> >> +  u32 id;
> >> +  struct evms_version version;
> >> +  struct evms_version required_services_version;
> >> +  struct evms_plugin_fops *fops;
> >> +  struct list_head headers;
> >> +};
> 
> > What is the required services version?
> 
> The common services are a set of functions exported
> by the core code. We have major,minor,patchlevel
> versions for them. Plugin writers specify the
> version of the interface they are coded to comply
> with. Mismatching core services and plugin
> version expectations are caught at plugin registration
> (load) time, and prevented from being usable.

Doesn't work in a linux enviroment.  People just have to stick to the
kernel version they write for.  If you think you really need it make
such checks at the cpp level as there is no such thing as binary
compatiblity anyway.

> the IOCTL entry point is used to send to volumes.
> the DIRECT_IOCTL entry point is used for point-
> to-point ioctls between corresponding user space
> and kernel space plugins.

Do the ioctl directly to the device node of the lower layer plugin instead.

> 
> >> +/**
> >> + * convenience macros to use plugin's fops entry points
> >> + **/
> >> +#define DISCOVER(node, list) ((plugin)->fops->discover(list))
> >> +#define END_DISCOVER(node, list) ((plugin)->fops->end_discover(list))
> >> +#define DELETE(node) ((node)->plugin->fops->delete(node))
> >> +#define SUBMIT_IO(node, bio) ((node)->plugin->fops->submit_io(node,
> bio))
> >> +#define INIT_IO(node, rw_flag, start_sec, num_secs, buf_addr) >((node)
> ->plugin->fops->init_io(node, rw_flag, start_sec, num_secs, buf_addr))
> >> +#define IOCTL(node, inode, file, cmd, arg)    ((node)
> ->plugin->fops->ioctl(node, >inode, file, cmd, arg))
> >> +#define DIRECT_IOCTL(plugin, inode, file, cmd, arg)   >((plugin)
> ->fops->direct_ioctl(inode, file, cmd, arg))
> 
> > Do you really need those wrapper?
> 
> No the wrappers aren't really needed. However they do make the
> code a great deal more readable.
> 
> > They just obsfucate the code
> 
> The same argument could be made about *all* macros then.
> Its simply a tradeoff between readability and potential
> hiding.

CodingStyle is one big flamewar.  As no other operations vector
in the linux kernel uses such wrappers the syle police seems to
be on my side in this case :)

