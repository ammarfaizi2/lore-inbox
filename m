Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUFXNL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUFXNL0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUFXNKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:10:34 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:10274 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S264479AbUFXNEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:04:36 -0400
Message-ID: <40DADF72.5060308@fastmail.fm>
Date: Thu, 24 Jun 2004 15:04:34 +0100
From: Sam Elstob <samelstob@fastmail.fm>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Olaf Dabrunz <od@suse.de>, Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
References: <40d9ac40.674.0@eth.net> <200406231853.35201.mrwatts@fast24.co.uk> <1088016048.15211.10.camel@sage.kitchen> <001901c459cd$bc436e40$868209ca@home> <20040624115019.GA3614@suse.de>
In-Reply-To: <20040624115019.GA3614@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dabrunz wrote:
> On 24-Jun-04, Amit Gud wrote:
> 
>>Ok, this is what I propose:
>>
>>    Lets say there are just 2 users with 100 megs of individual quota, user
>>A is using 20 megs and user B is running out of his quota. Now what B could
>>do is delete some files himself and make some free space for storing other
>>files. Now what I say is instead of deleting the files, he declares those
>>files as elastic.
>>
>>Now, moment he makes that files elastic, that much amount of space is added
>>to his quota. Here Mark Cooke's equation applies with some modifications:
>>N no. of users,
>>Qi allocated quota of ith user
>>Ui individual disk usage of ith user ( should be <= allocated quota of ith
>>user ),
>>D disk threshold; thats the amount of disk space admin wants to allow the
>>users to use (should be >= sum of all users' allocated quota, i.e. summation
>>Qi ; for i = 0 to N - 1).
>>
>>Total usage of all the users (here A & B) should be at _anytime_ less than
>>D. i.e. summation Ui <= D; for i = 0 to N - 1.
>>
>>The point to note here is that we are not bothering how much quota has been
>>allocated to an individual user by the admin, but we are more interested in
>>the usage pattern followed by the users. E.g. if user B wants additional
>>space of say 25 megs, he picks up 25 megs of his files and 'marks' them
>>elastic. Now his quota is increased to 125 megs and he can now add more 25
>>megs of files; at the same time allocated quota for user A is left
>>unaffected. Applying the above equation total usage now is A: 20 megs, B:
>>125 megs, now total 145 <= D, say 200 megs. Thus this should be ok for the
>>system, since the usage is within bounds.
>>
>>Now what happens if Ui > D? This can happen when user A tries to recliam his
>>space. i.e. if user A adds say more 70 megs of files, so the total usage is
>>now - A: 90 megs, B: 125 megs; 215 ! <= D. The moment the total usage
>>crosses the value, 'action' will be taken on the elastic files. Here elastic
>>files are of user B so only those will be affected and users A's data will
>>be untouched, so in a way this will be completely transparent to user A.
>>What action should be taken can be specified by the user while making the
>>files elastic. He can either opt to delete the file, compress it or move it
>>to some place (backup) where he know he has write access. The corresponding
> 
> 
> - having files disappear at the discretion of the filesystem seems to be
>   bad behaviour: either I need this file, then I do not want it to just
>   disappear, or I do not need it, and then I can delete it myself.
> 
>   Since my idea of which files I need and which I do not need changes
>   over time, I believe it is far better that I can control which files I
>   need and which I do not need whenever other constraints (e.g. quota
>   filled up) make this decision necessary. Also, then I can opt to try
>   to convince someone to increase my quota.
> 
> - moving the file to some other place (backup) does not seem to be a
>   viable option:
> 
>   - If the backup media is always accessible, then why can't the user
>     store the "elastic" files there immediately?
>     -> advantages:
>       - the user knows where his file is
>       - applications that remember the path to a file will be able to
> 	access it
> 
>   - If the backup media will only be accessible after manually inserting
>     it into some drive, this amounts to sending an E-Mail to the backup
>     admin and then pass a list of backup files to the backup software.
> 
>     But now getting the file back involves a considerable amount of
>     manual and administrative work. And it involves bugging the backup
>     admin, who now becomes the bottleneck of your EQFS.
> 
> So this narrows down to the effective handling of backup procedures and
> the effective administration of fixed quotas and centralization of data.
> 
> If you have many users it is also likely that there are more people
> interested in big data-files. So you need to help these people organize
> themselves e.g. by helping them to create mailing-list, web-pages or
> letting them install servers that makes the data centrally available
> with some interface that they can use to select parts of the data.
> 
> I would rather suggest that if the file does not fit within a given
> quota, the user should apply for more quota and give reasons for that.
> 
> I believe that flexible or "elastic" allocation of ressources is a good
> idea in general, but it only works if you have cheap and easy ways to
> control both allocation and deallocation. So in the case of CBQ in
> networks this works, since bandwidth can easily and quickly be allocated
> and deallocated.
> 
> But for filesystem space this requires something like a "slower (= less
> expensive), bigger, always accessible" third level of storage in the
> "RAM, disk, ..." hierarchy. And then you would need an easy or even
> transparent way to access files on this third level storage. And you
> need to make sure that, although you obviously *need* the data for
> something, you still can afford to increase retrieval times by several
> orders of magnitude at the discretion of the filesystem.
> 
> But usually all this can be done by scripts as well.
> 
> Still, there is a scenario and a combination of features for such a
> filesystem that IMHO would make it useful:
> 
> - Provide allocation of overquota as you described it.
> - Let the filesystem move (parts of) the "elastic" files to some
>   third-level backing-store on an as-needed basis. This provides you
>   with a not-so-cheap (but cheaper than manual handling) resource
>   management facility.
> 
> Now you can use the third-level storage as a backing store for
> hard-drive space, analoguous to what swap-space provides for RAM. And
> you can "swap in" parts of files from there and cache them on the hard
> drive. So "elastic" files are actually files that are "swappable" to
> backing store.
> 
> This assumes that the "elastic" files meet the requirements for a
> "working set" in a similar fashion as for RAM-based data. I.e. the swap
> operations need only be invoked relatively seldom.
> 
> If this is not the case, your site/customer needs to consider buying
> more hard drive space (and maybe also RAM).
> 
> 
> The tradeoff for the user now is:
>     - do not have the big file(s) OR
>     - have them and be able to use them in a random-access fashion from
>       any application, but maybe only with a (quite) slow access time,
>       but without additional administrative/manual hassle
> 
> Maybe this is a good tradeoff for a significant amount of users. Maybe
> there are sites/customers that have the required backing store (or would
> consider buying into this). I do not know. Find a sponsor, do some field
> research and give it a try.
> 
> 
>>action will be taken until the threshold is met.
>>
>>Will this work?? We are relying on the 'free' space ( i.e. D - Ui ) for the
>>users to benefit. The chances of having a greater value for D - Ui increases
>>with the increase in the number of users, i.e. N. Here we are talking about
>>2 users but think of 10000+ users where all the users will probably never
>>use up _all_ the allocated disk space. This user behavior can be well
>>exploited.
>>
>>EQFS can be best fitted in the mail servers. Here e.g. I make whole
>>linux-kernel mailing list elastic. As long as Ui <= D I get to keep all the
>>messages, whenever Ui > D, messages with latest dates will be 'acted' upon.
>>
>>For variable quota needs, admin can allocate different quotas for different
>>users, but this can get tiresome when N is large. With EQFS, he can allocate
>>fixed quota for each user ( old and new ) , set up a value for D and relax.
>>The users will automatically get the quota they need. One may ask that this
>>can be done by just setting up value of D, checking it against summation Ui
>>and not allocating individual quotas at all. But when summation Ui crosses D
>>value, whose file to act on? Moreover with both individual quotas and D, we
>>give users 'controlled' flexibility just like elastic - it can be stretched
>>but not beyond a certain range.
>>
>>What happens when an user tries to eat up all the free ( D - Ui ) space?
>>This answer is implementation dependent because you need to make a decision:
>>should an user be allowed to make a file elastic when Ui == D . I think by
>>saying 'yes' we eliminate some users' mischief of eating up all free space.
>>
>>Queries, comments, suggestions welcome.
>>
>>regs,
>>AG
>>
>>
>>>On Wed, 2004-06-23 at 18:53, Mark Watts wrote:
>>>
>>>>>Greetings,
>>>>>
>>>>>I think I should discuss this in the list...
>>>>>
>>>>>Recently I'm into developing an Elastic Quota File System (EQFS). This
>>>>>file system works on a simple concept ... give it to others if you're
>>
>>not
>>
>>>>>using it, let others use it, but on the guarantee that you get it back
>>
>>when
>>
>>>>>you need it!!
>>>>
>>>>How do you intend to guarantee this?
>>>>Randomly deleting a users files to free up disk space is a Bad (tm)
>>
>>idea, so
>>
>>>>what other mechanism are you going to employ?
>>>
>>>Hi Mark, Amit,
>>>
>>>Simple example of a flexible quota scheme:
>>>
>>>N users with Q megabytes of guaranteed quota
>>>D total megs of disk storage
>>>The difference D - N*Q is the amount you can be flexible with.
>>>
>>>
>>>The above is a somewhat different scheme than the 'give your unused
>>>quota back to others' part of Amit's post though.
>>>
>>>If Amit does actually mean to have a situation where the remaining
>>>guaranteed quota is less than the actual remaining free space, there is
>>>*no way* to satisfy the guarantee.
>>>
>>>Imagine the worst case scenario if all users suddenly want their
>>>guaranteed quota.  The only way to free up space is deleting files from
>>>over-quota users - something which would be unacceptable operationally,
>>>IMHO.
>>>
>>>
>>>That said, I'll read your tech description with interest when it comes
>>>out,
>>>
>>>Mark
>>>
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

Amit

I agree that the situation with 10000+ users is where such a filesystem 
becomse useful.  It is the difference between actual disk usage and sum 
of all disk quota that provides the elastisicty.

Imagine an ISP providing free mail with an advertised quota of 1GB per 
user.  With 100,000 users, 100TB of storage would be needed.  However, 
it is likely that most users would not use their full quota meaning a 
lot of wasted storage capacity, at the expense of the mail provider. 
What if the EFS could allow the sum of all advertised quotas to total 
more than the actual online disk capacity.  Assuming average quota usage 
settles down and doesn't suddenly change on mass the actual online 
storage capacity of the system could be much lower (and thus cheaper) 
than the case where every user is at full quota.  When the actual disk 
usage reaches, say 70%, of the attached capacity the administrator could 
be notified and action taken e.g. attach more disks and extend the 
volume, or backup and delete dead accounts.

I'm talking about the case where large (10000>) numbers of users are 
involved with a habit of using less than some advertised quota. 
Obviously the adverised quota is still available to those who want it, 
but overall the necessary disk space is less than the sum of all 
advertised disk quotas.

Sam Elstob
