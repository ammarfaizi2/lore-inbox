Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTFFQSH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTFFQSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:18:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:45193 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261868AbTFFQSB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:18:01 -0400
Date: Fri, 6 Jun 2003 11:31:22 -0500
Subject: Re: [CHECKER][PATCH] awe_wave.c user pointer dereference
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@digeo.com>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <20030605155225.4b1c64b3.akpm@digeo.com>
Message-Id: <4F5CFABE-983C-11D7-8338-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, Jun 5, 2003, at 17:52 US/Central, Andrew Morton wrote:

> Hollis Blanchard <hollisb@us.ibm.com> wrote:
>>
>> +			return -EFAULT;
>>  		return 0;
>>  		break;
>>
>> @@ -2063,10 +2064,12 @@
>>
>>  	case SNDCTL_SYNTH_MEMAVL:
>>  		return memsize - awe_free_mem_ptr() * 2;
>> +		break;
>>
>>  	default:
>>  		printk(KERN_WARNING "AWE32: unsupported ioctl %d\n", cmd);
>>  		return -EINVAL;
>> +		break;
>
> There's no need for a "break" after a "return"!

I've gotten a couple questions about that. :)

I did it for two reasons: 1) I'm a big fan of consistancy, and 3 of the 
5 ioctl cases already had the break. 2) should the returns be replaced 
with something like "retval = -EINVAL" and a single "return retval" at 
the end of the function, I can easily imagine visually missing the need 
for a break.

However, although a break after a return is fine with gcc -Wall, Joe 
Perches informs me that it will annoy lint and the Intel compiler. So 
here is the updated patch, which removes the (pre-existing! :) breaks 
from the other cases.

-- 
Hollis Blanchard
IBM Linux Technology Center

===== sound/oss/awe_wave.c 1.12 vs edited =====
--- 1.12/sound/oss/awe_wave.c	Thu Apr  3 16:35:48 2003
+++ edited/sound/oss/awe_wave.c	Fri Jun  6 11:17:19 2003
@@ -2046,20 +2046,18 @@
  			awe_info.nr_voices = awe_max_voices;
  		else
  			awe_info.nr_voices = AWE_MAX_CHANNELS;
-		memcpy((char*)arg, &awe_info, sizeof(awe_info));
+		if (copy_to_user((char*)arg, &awe_info, sizeof(awe_info)))
+			return -EFAULT;
  		return 0;
-		break;

  	case SNDCTL_SEQ_RESETSAMPLES:
  		awe_reset(dev);
  		awe_reset_samples();
  		return 0;
-		break;

  	case SNDCTL_SEQ_PERCMODE:
  		/* what's this? */
  		return 0;
-		break;

  	case SNDCTL_SYNTH_MEMAVL:
  		return memsize - awe_free_mem_ptr() * 2;
@@ -4314,7 +4312,8 @@
  	if (((cmd >> 8) & 0xff) != 'M')
  		return -EINVAL;

-	level = *(int*)arg;
+	if (get_user(level, (int *)arg))
+		return -EFAULT;
  	level = ((level & 0xff) + (level >> 8)) / 2;
  	DEBUG(0,printk("AWEMix: cmd=%x val=%d\n", cmd & 0xff, level));

@@ -4370,7 +4369,9 @@
  		level = 0;
  		break;
  	}
-	return *(int*)arg = level;
+	if (put_user(level, (int *)arg))
+		return -EFAULT;
+	return level;
  }
  #endif /* CONFIG_AWE32_MIXER */
  

