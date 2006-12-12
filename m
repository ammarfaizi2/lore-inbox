Return-Path: <linux-kernel-owner+w=401wt.eu-S932389AbWLLTVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWLLTVz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWLLTVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:21:55 -0500
Received: from web57810.mail.re3.yahoo.com ([68.142.236.88]:42389 "HELO
	web57810.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932389AbWLLTVy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:21:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6Ly24IImkEeWvsFUhHKsBpTrvtYlsN1wUDEX2l38FWU0qqjv7QjzILkniyX+Ma8Ul9m+SSvmoyL5ln8dzqMUILSCzHw4BZ6X+Igz0wHbKoED7AAUJ6a6XuSxkdKwu8/9vhtmootyMbsat15tPemVakqlz7Ah6p9n0E9HThZVKHU=  ;
Message-ID: <20061212192153.69121.qmail@web57810.mail.re3.yahoo.com>
Date: Tue, 12 Dec 2006 11:21:53 -0800 (PST)
From: Rakhesh Sasidharan <rakheshster@yahoo.com>
Reply-To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Subject: Re: VCD not readable under 2.6.18
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: caglar@pardus.org.tr, Ismail Donmez <ismail@pardus.org.tr>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again!

I realize what I am going to post below is OT to this list, but I thought I'd mention it here anyways just in case some other user is having a similar problem and happens to follow this thread in the hope of finding a solution. I've tested this on Fedora Core 6 and openSUSE 10.2, both running GNOME, and it works. 

As I mentioned in my previous mail, this VCDs not readable problem is not a kernel one. The newer kernels are more vocal about the errors, and refuse to mount the VCDs, but the problem is one of HAL-kernel interaction. To verify that, boot into single user mode, and its possible to mount VCDs without any problems. 

As a temporary work-around for those who wish to watch VCDs and are unable to coz of this problem, all one needs to do is disable HAL from polling the CD/ DVD drive. I stumbled upon this idea by doing a "ps ax |grep hald" and noticing that there's an entry for "hald-addon-storage: polling /dev/hdc". I killed this process, and bingo! I could mount VCDs perfectly fine! Ofcourse, killing this process has the side effect that none of your CDs are automatically mounted any more (till the next reboot that is). 

If you wish to permanently stop polling of the CD/ DVD drive, then you have to edit the HAL policy file for storage devices (located at "/usr/share/hal/fdi/policy/10osvendor/20-storage-methods.fdi" in the distros I mentioned above). In my case, this is how the first few lines of that file looked like: 

<?xml version="1.0" encoding="UTF-8"?>

<deviceinfo version="0.2">
  <device>
    <match key="info.udi" string="/org/freedesktop/Hal/devices/computer">
      <append key="info.callouts.add" type="strlist">hal-storage-cleanup-all-mo$
    </match>

    <match key="storage.media_check_enabled" bool="true">
      <append key="info.addons" type="strlist">hald-addon-storage</append>
    </match>

The key here is the part that goes as 'key="storage.media_check_enabled" bool="true"'. This is what tells HAL to keep polling the drives. What we want to do now is disable polling for CD/DVD drives, and so we add something like this *before* the above stuff: 

  <!-- Temporary hack to solve my VCD problem -->
  <device>
    <match key="storage.bus" string="ide">
      <!-- <match key="storage.model" string="TSSTcorpCD/DVDW TS-L532M"> -->
        <match key="block.device" string="/dev/hdc">
          <merge key="storage.media_check_enabled" type="bool">false</merge>
        </match>
      <!-- </match> -->
    </match>
  </device>

In my case, the CD/ DVD drive is /dev/hdc. Which is why I am matching on that and changing its polling to false. Its also possible to match based on the model etc etc (in my case I've commented that out with <!-- to -->). 

This is how the first few lines of the storage policies file looks, after the changes: 

<?xml version="1.0" encoding="UTF-8"?>



<deviceinfo version="0.2">

  <!-- Temporary hack to solve my VCD problem -->

  <device>

    <match key="storage.bus" string="ide">

      <!-- <match key="storage.model" string="TSSTcorpCD/DVDW TS-L532M"> -->

        <match key="block.device" string="/dev/hdc">

          <merge key="storage.media_check_enabled" type="bool">false</merge>

        </match>

      <!-- </match> -->

    </match>

  </device>

  <device>

    <match key="info.udi" string="/org/freedesktop/Hal/devices/computer">

      <append key="info.callouts.add" type="strlist">hal-storage-cleanup-all-mo$

    </match>



    <match key="storage.media_check_enabled" bool="true">

      <append key="info.addons" type="strlist">hald-addon-storage</append>

    </match>


After making the changes, restart HAL, and the problem is solved! :) 

I figure readers of the LKML probably know all this stuff well; but I didn't, and it took me a bit of effort to figure what to do, and that's why I am posting it all here. A special mention to this link -- http://ubuntuforums.org/archive/index.php/t-64388.html -- from where I got an idea of where the policy files are located and what I could do. 

Guess that's all for now. 

Thanks,
Rakhesh

ps. Any replies, please cc me. I am not subscribed to this list.

----- Original Message ----
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Rakhesh Sasidharan <rakhesh@rakhesh.com>
Cc: rakheshster@yahoo.com; caglar@pardus.org.tr; Ismail Donmez <ismail@pardus.org.tr>; linux-kernel@vger.kernel.org
Sent: Sunday, December 10, 2006 4:44:42 AM
Subject: Re: VCD not readable under 2.6.18

On Sat, 9 Dec 2006 09:23:32 -0800 (PST)
Rakhesh Sasidharan <rakheshster@yahoo.com> wrote:

> Infact, just inserting a CD is enough. No need for a media player to try and access the files. :)
> 
> The backend must be polling and trying to mount the disc upon insertion. Kernel 2.6.16 and before did that fine, but kernel 2.6.17 and above don't and give error messages. Which explains why downgrading the kernel solves the problem. (If it were a HAL or KDE/ GNOME problem then shouldn't downgrading the kernel *not* help?) Just thinking aloud ... 

The old kernel erroneously failed to report errors in some cases so the
answer to that bit is a definite  - no -. That side is a desktop problem.
The fact people are saying that in addition vcd players are breaking is a
bit more mysterious.





 
____________________________________________________________________________________
Any questions? Get answers on any topic at www.Answers.yahoo.com.  Try it now.
