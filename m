Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263056AbTDBQYK>; Wed, 2 Apr 2003 11:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263059AbTDBQYK>; Wed, 2 Apr 2003 11:24:10 -0500
Received: from holomorphy.com ([66.224.33.161]:49798 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263056AbTDBQYI>;
	Wed, 2 Apr 2003 11:24:08 -0500
Date: Wed, 2 Apr 2003 08:35:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030402163512.GC993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org,
	Robert Love <rml@tech9.net>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030401164126.GA993@holomorphy.com> <20030401221927.GA8904@wind.cocodriloo.com> <20030402124643.GA13168@wind.cocodriloo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030402124643.GA13168@wind.cocodriloo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 02, 2003 at 02:46:43PM +0200, Antonio Vargas wrote:
+static inline void update_user_timeslices(void)
...
+	list_for_each(entry, &user_list) {
+		user = list_entry(entry, struct user_struct, uid_list);
+
+		if(!user) continue;
+
+		if(0){
+			user_time_slice = user->time_slice;

Hmm, this looks very O(n)... BTW, doesn't uidhash_lock lock user_list?


On Wed, Apr 02, 2003 at 02:46:43PM +0200, Antonio Vargas wrote:
> @@ -39,10 +42,12 @@ struct user_struct root_user = {
>  static inline void uid_hash_insert(struct user_struct *up, struct list_head *hashent)
>  {
>  	list_add(&up->uidhash_list, hashent);
> +	list_add(&up->uid_list, &user_list);
>  }

Okay, there are three or four problems:

(1) uidhash_lock can't be taken in interrupt context
(2) you aren't taking uidhash_lock at all in update_user_timeslices()
(3) you're not actually handing out user timeslices due to an if (0)
(4) walking user_list is O(n)


-- wli
