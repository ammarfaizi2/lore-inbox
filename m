Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264986AbUFRJid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264986AbUFRJid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 05:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUFRJid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 05:38:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:13317 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264986AbUFRJi2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 05:38:28 -0400
Message-ID: <40D2B8C3.8090908@hist.no>
Date: Fri, 18 Jun 2004 11:41:23 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@linuxhacker.ru>
CC: Petter Larsen <pla@morecom.no>, linux-kernel@vger.kernel.org,
       ext3 <ext3-users@redhat.com>
Subject: Re: mode data=journal in ext3. Is it safe to use?
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan> <1087322976.1874.36.camel@pla.lokal.lan> <200406160734.i5G7YZwV002051@car.linuxhacker.ru> <1087460837.2765.31.camel@pla.lokal.lan> <20040617170939.GO2659@linuxhacker.ru>
In-Reply-To: <20040617170939.GO2659@linuxhacker.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

>Hello!
>
>On Thu, Jun 17, 2004 at 10:27:17AM +0200, Petter Larsen wrote:
>  
>
>>>PL> Can anybody of you acknowledge or not if mode data=journal in ext3 is
>>>PL> safe to use in Linux kernel 2.6.x?
>>>PL> Wee need to have a very consistent and integrity for our filesystem, and
>>>PL> it would then be desired to journal both data and metadata.
>>>OLEG> Actually data=journal mode would gain you mostly zero extra consistency compared
>>>to data=ordered mode. (the only more consistency bit that you get is
>>>correct mtime on files that have their pages overwritten, I think).
>>>You have zero control over transaction boundaries in ext3, so you still need
>>>to design your applications in such a way that they have their own
>>>sort of transactions (if this is needed).
>>>      
>>>
>>So your conclusion is that data=journal mode is useless if you do not
>>want a correct mtime?
>>    
>>
>
>Well, yes.
>
>  
>
>>It would be a littles sense in developing the data=journal mode if this
>>is the only benefit, don't you think?
>>>From the Linux/Documentation/filesystems/ext3.txt
>>data=journal            All data are committed into the journal prior
>>                        to being written into the main file system.
>>data=ordered    (*)     All data are forced directly out to the main
>>file                    system prior to its metadata being committed to
>>                        the journal.
>>My problem is that ext3 in the latest kernel, 2.6.x and the latest
>>2.4.x, are not well documented around the web. Whitepapers and so are
>>pretty old. Much have changed I belive in ext3 since it was first
>>introduced by Dr. Tweedie. The first release was journaling both data
>>and metadata, se also the transcript from Dr. Tweedie from the Ottawa
>>Linux Symposium 20th July 2000.
>>http://olstrans.sourceforge.net/release/OLS2000-ext3/OLS2000-ext3.html
>>There he says that they are journaling both metadata and data, but that
>>the design goal is not to do that. So can this be interpreted that mode
>>data=journal is only there for historic reasons?
>>    
>>
>
>May be so. Also fsync heavy loads on real disk devices with large journals
>tend to benefit from journaled data mode as well.
>
>  
>
>>>PL> Data integrity is much more important for us than speed.
>>>
>>>OLEG> It is not clear what sort of extra data integrity do you expect from data
>>>journaling mode and why do you think it is there.
>>>      
>>>
>>I would belive that the goal for such a mode data=journal would gain
>>extra data integrity because it also journals data. Why should it not? I
>>    
>>
>
>Well, actually I bet you do not care if the data goes through journal or not
>as long as it is not lost.
>In case of ordered journaling mode, data is written first before metadata
>updates, mostly the same happens with data journal mode, only with the latter
>case date is written into journal and if transaction was not committed, after
>a reboot it won't be copied to where it should be, same scenario in ordered
>journal mode will result in data getting where it should be, but due to
>lack of metadata updates, you won't see it. (this is in case of append,
>for overwrite it will be a little bit different, but still you have no
>control over how much of stuff will be overwritten).
>
>  
>
>>would belive that it makes sense to have these different modes so people
>>can choose the best mode for there applications.
>>    
>>
>
>True.
>
>  
>
>>>OLEG> Garbage in files should not happen in data ordered mode as data pages are
>>>written first before metadata updates are committed.
>>>      
>>>
>>Are you sure?
>>    
>>
>
>If you can reproduce a garbage in files in ordered journal mode, that would be a
>bug that should be fixed then.
>  
>
Hard to _produce_, but consider:
1. Write data to an existing file
2. Sync metadata
3. data is forced out because of ordered mode, a powerout crash happens
    in the middle of this. The file now has a block with a mix of new 
and old,
    it may even be unreadable due to a bad sector checksum.

With data journalling you either get the old data (because the crash 
happened
during a write to the journal) or new data (crash happened during data 
write,
the data is restored from the good copy in the journal.)

Helge Hafting
