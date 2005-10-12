Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVJLGhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVJLGhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 02:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVJLGhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 02:37:24 -0400
Received: from iron.cat.pdx.edu ([131.252.208.92]:52902 "EHLO iron.cat.pdx.edu")
	by vger.kernel.org with ESMTP id S1751222AbVJLGhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 02:37:23 -0400
Date: Tue, 11 Oct 2005 23:36:59 -0700 (PDT)
From: Suzanne Wood <suzannew@cs.pdx.edu>
Message-Id: <200510120636.j9C6axcq003869@rastaban.cs.pdx.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, neilb@cse.unsw.edu.au, paulmck@us.ibm.com,
       walpole@cs.pdx.edu
Subject: Re: [RFC][PATCH] identify raid rcu-protected pointer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From "Paul E. McKenney" October 11, 2005 4:02 PM

> On Tue, Oct 11, 2005 at 02:48:37PM -0700, Suzanne Wood wrote:
> 
> Acked-by: <paulmck@us.ibm.com>
> 
> Thanx, Paul

Thank you.  Recognizing that the comment in raid1.c will be
addressed and/or removed, please consider this.

Signed-off-by: <suzannew@cs.pdx.edu>

> 
>> Elements of this patch were submitted Oct 5-6, 2005, but
>> are being resent with some explanation of reasoning employed
>> and additions. Insertions of rcu_dereference() 
>> are done in response to previously marked rcu readside 
>> critical sections with corresponding rcu_assign_pointer().
>>
>> Because synchronize_rcu() occurs after p->rdev = NULL; 
>> in the five files (multipath.c, raid10.c, raid1.c, 
>> raid5.c, and raid6main.c) within drivers/md, it is 
>> thought that the rcu_dereference() protects the later 
>> dereference of that pointer which is type mdk_rdev_t
>> defined in md_k.h for the struct mdk_rdev_s for the 
>> extended device.
>> 
>> In a case like the following from raid10.c:
>>         while (!conf->mirrors[disk].rdev ||
>>                !conf->mirrors[disk].rdev->in_sync) {
>> 
>> with no assignment of the rdev, the thought is that
>> an rcu-dereference() of the rdev protects the access
>> of, e.g, in_sync.  While in_sync is an integer (flag),
>> it's validity for the current object would be protected.
>> More likely, a temporary variable will be used in
>> read_balance() as seen in raid1.c, e.g.:
>>   rdev = conf->mirrors[new_disk].rdev)
>> 
>> In read_balance() of raid1.c, it was assumed that the 
>> extent of the rcu readside critical section was due to 
>> the "retry" label and the possibility of desiring to be 
>> external to the loop, but the "goto retry" is nested 
>> in 2 levels of conditionals.  This may indicate 
>> a reconsideration of the placement of rcu_read_lock()/
>> unlock().  raid10.c read_balance() may also merit
>> reevaluation.
>> 
>> The rcu_assign_pointer(rdev->mddev, mddev) is inserted
>> to make the mddev object globally visible because it
>> is the structure referenced by the rcu protected rdev
>> pointer.  Other assignments to rdev fields in md.c 
>> appear to be in regard to initialization, but the
>> developer will want to consider this.  
>> 
>> Thank you.
>>
>> ----------------------------------------------------
>> 
>>  md.c        |    2 +-
>>  multipath.c |    6 +++---
>>  raid1.c     |   18 +++++++++---------
>>  raid10.c    |   14 +++++++-------
>>  raid5.c     |    8 ++++----
>>  raid6main.c |    6 +++---
>>  6 files changed, 27 insertions(+), 27 deletions(-)
>> 
>> ----------------------------------------------------
>> 
>> diff -urpNa -X dontdiff linux-2.6.14-rc4/drivers/md/md.c linux-2.6.14-rc4_patch/drivers/md/md.c
>> --- linux-2.6.14-rc4/drivers/md/md.c 2005-10-10 18:19:19.000000000 -0700
>> +++ linux-2.6.14-rc4_patch/drivers/md/md.c 2005-10-11 13:30:22.000000000 -0700
>> @@ -1145,7 +1145,7 @@ static int bind_rdev_to_array(mdk_rdev_t
>>  }
>>  
>>  list_add(&rdev->same_set, &mddev->disks);
>> - rdev->mddev = mddev;
>> + rcu_assign_pointer(rdev->mddev, mddev);
>>  printk(KERN_INFO "md: bind<%s>\n", bdevname(rdev->bdev,b));
>>  return 0;
>>  }
>> diff -urpNa -X dontdiff linux-2.6.14-rc4/drivers/md/multipath.c linux-2.6.14-rc4_patch/drivers/md/multipath.c
>> --- linux-2.6.14-rc4/drivers/md/multipath.c 2005-10-10 18:19:19.000000000 -0700
>> +++ linux-2.6.14-rc4_patch/drivers/md/multipath.c 2005-10-11 10:28:33.000000000 -0700
>> @@ -63,7 +63,7 @@ static int multipath_map (multipath_conf
>>  
>>  rcu_read_lock();
>>  for (i = 0; i < disks; i++) {
>> - mdk_rdev_t *rdev = conf->multipaths[i].rdev;
>> + mdk_rdev_t *rdev = rcu_dereference(conf->multipaths[i].rdev);
>>  if (rdev && rdev->in_sync) {
>>  atomic_inc(&rdev->nr_pending);
>>  rcu_read_unlock();
>> @@ -139,7 +139,7 @@ static void unplug_slaves(mddev_t *mddev
>>  
>>  rcu_read_lock();
>>  for (i=0; i<mddev->raid_disks; i++) {
>> - mdk_rdev_t *rdev = conf->multipaths[i].rdev;
>> + mdk_rdev_t *rdev = rcu_dereference(conf->multipaths[i].rdev);
>>  if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
>>  request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
>>  
>> @@ -228,7 +228,7 @@ static int multipath_issue_flush(request
>>  
>>  rcu_read_lock();
>>  for (i=0; i<mddev->raid_disks && ret == 0; i++) {
>> - mdk_rdev_t *rdev = conf->multipaths[i].rdev;
>> + mdk_rdev_t *rdev = rcu_dereference(conf->multipaths[i].rdev);
>>  if (rdev && !rdev->faulty) {
>>  struct block_device *bdev = rdev->bdev;
>>  request_queue_t *r_queue = bdev_get_queue(bdev);
>> diff -urpNa -X dontdiff linux-2.6.14-rc4/drivers/md/raid10.c linux-2.6.14-rc4_patch/drivers/md/raid10.c
>> --- linux-2.6.14-rc4/drivers/md/raid10.c 2005-10-10 18:19:19.000000000 -0700
>> +++ linux-2.6.14-rc4_patch/drivers/md/raid10.c 2005-10-11 14:09:20.000000000 -0700
>> @@ -510,7 +510,7 @@ static int read_balance(conf_t *conf, r1
>>  slot = 0;
>>  disk = r10_bio->devs[slot].devnum;
>>  
>> - while (!conf->mirrors[disk].rdev ||
>> + while (!rcu_dereference(conf->mirrors[disk].rdev) ||
>>         !conf->mirrors[disk].rdev->in_sync) {
>>  slot++;
>>  if (slot == conf->copies) {
>> @@ -527,7 +527,7 @@ static int read_balance(conf_t *conf, r1
>>  /* make sure the disk is operational */
>>  slot = 0;
>>  disk = r10_bio->devs[slot].devnum;
>> - while (!conf->mirrors[disk].rdev ||
>> + while (!rcu_dereference(conf->mirrors[disk].rdev) ||
>>         !conf->mirrors[disk].rdev->in_sync) {
>>  slot ++;
>>  if (slot == conf->copies) {
>> @@ -547,7 +547,7 @@ static int read_balance(conf_t *conf, r1
>>  int ndisk = r10_bio->devs[nslot].devnum;
>>  
>>  
>> - if (!conf->mirrors[ndisk].rdev ||
>> + if (!rcu_dereference(conf->mirrors[ndisk].rdev) ||
>>      !conf->mirrors[ndisk].rdev->in_sync)
>>  continue;
>>  
>> @@ -569,7 +569,7 @@ rb_out:
>>  r10_bio->read_slot = slot;
>>  /* conf->next_seq_sect = this_sector + sectors;*/
>>  
>> - if (disk >= 0 && conf->mirrors[disk].rdev)
>> + if (disk >= 0 && rcu_dereference(conf->mirrors[disk].rdev))
>>  atomic_inc(&conf->mirrors[disk].rdev->nr_pending);
>>  rcu_read_unlock();
>>  
>> @@ -583,7 +583,7 @@ static void unplug_slaves(mddev_t *mddev
>>  
>>  rcu_read_lock();
>>  for (i=0; i<mddev->raid_disks; i++) {
>> - mdk_rdev_t *rdev = conf->mirrors[i].rdev;
>> + mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
>>  if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
>>  request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
>>  
>> @@ -614,7 +614,7 @@ static int raid10_issue_flush(request_qu
>>  
>>  rcu_read_lock();
>>  for (i=0; i<mddev->raid_disks && ret == 0; i++) {
>> - mdk_rdev_t *rdev = conf->mirrors[i].rdev;
>> + mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
>>  if (rdev && !rdev->faulty) {
>>  struct block_device *bdev = rdev->bdev;
>>  request_queue_t *r_queue = bdev_get_queue(bdev);
>> @@ -772,7 +772,7 @@ static int make_request(request_queue_t 
>>  rcu_read_lock();
>>  for (i = 0;  i < conf->copies; i++) {
>>  int d = r10_bio->devs[i].devnum;
>> - if (conf->mirrors[d].rdev &&
>> + if (rcu_dereference(conf->mirrors[d].rdev) &&
>>      !conf->mirrors[d].rdev->faulty) {
>>  atomic_inc(&conf->mirrors[d].rdev->nr_pending);
>>  r10_bio->devs[i].bio = bio;
>> diff -urpNa -X dontdiff linux-2.6.14-rc4/drivers/md/raid1.c linux-2.6.14-rc4_patch/drivers/md/raid1.c
>> --- linux-2.6.14-rc4/drivers/md/raid1.c 2005-10-10 18:19:19.000000000 -0700
>> +++ linux-2.6.14-rc4_patch/drivers/md/raid1.c 2005-10-11 13:23:23.000000000 -0700
>> @@ -416,10 +416,10 @@ static int read_balance(conf_t *conf, r1
>>  /* Choose the first operation device, for consistancy */
>>  new_disk = 0;
>>  
>> - for (rdev = conf->mirrors[new_disk].rdev;
>> + for (rdev = rcu_dereference(conf->mirrors[new_disk].rdev);
>>       !rdev || !rdev->in_sync
>>       || test_bit(WriteMostly, &rdev->flags);
>> -      rdev = conf->mirrors[++new_disk].rdev) {
>> +      rdev = rcu_dereference(conf->mirrors[++new_disk].rdev)) {
>>  
>>  if (rdev && rdev->in_sync)
>>  wonly_disk = new_disk;
>> @@ -434,10 +434,10 @@ static int read_balance(conf_t *conf, r1
>>  
>>  
>>  /* make sure the disk is operational */
>> - for (rdev = conf->mirrors[new_disk].rdev;
>> + for (rdev = rcu_dereference(conf->mirrors[new_disk].rdev);
>>       !rdev || !rdev->in_sync ||
>>       test_bit(WriteMostly, &rdev->flags);
>> -      rdev = conf->mirrors[new_disk].rdev) {
>> +      rdev = rcu_dereference(conf->mirrors[new_disk].rdev)) {  // increment new_disk? 
>>  
>>  if (rdev && rdev->in_sync)
>>  wonly_disk = new_disk;
>> @@ -474,7 +474,7 @@ static int read_balance(conf_t *conf, r1
>>  disk = conf->raid_disks;
>>  disk--;
>>  
>> - rdev = conf->mirrors[disk].rdev;
>> + rdev = rcu_dereference(conf->mirrors[disk].rdev);
>>  
>>  if (!rdev ||
>>      !rdev->in_sync ||
>> @@ -496,7 +496,7 @@ static int read_balance(conf_t *conf, r1
>>  
>>  
>>  if (new_disk >= 0) {
>> - rdev = conf->mirrors[new_disk].rdev;
>> + rdev = rcu_dereference(conf->mirrors[new_disk].rdev);
>>  if (!rdev)
>>  goto retry;
>>  atomic_inc(&rdev->nr_pending);
>> @@ -522,7 +522,7 @@ static void unplug_slaves(mddev_t *mddev
>>  
>>  rcu_read_lock();
>>  for (i=0; i<mddev->raid_disks; i++) {
>> - mdk_rdev_t *rdev = conf->mirrors[i].rdev;
>> + mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
>>  if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
>>  request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
>>  
>> @@ -547,6 +547,7 @@ static void raid1_unplug(request_queue_t
>>  md_wakeup_thread(mddev->thread);
>>  }
>>  
>>  static int raid1_issue_flush(request_queue_t *q, struct gendisk *disk,
>>       sector_t *error_sector)
>>  {
>> @@ -556,7 +557,7 @@ static int raid1_issue_flush(request_que
>>  
>>  rcu_read_lock();
>>  for (i=0; i<mddev->raid_disks && ret == 0; i++) {
>> - mdk_rdev_t *rdev = conf->mirrors[i].rdev;
>> + mdk_rdev_t *rdev = rcu_dereference(conf->mirrors[i].rdev);
>>  if (rdev && !rdev->faulty) {
>>  struct block_device *bdev = rdev->bdev;
>>  request_queue_t *r_queue = bdev_get_queue(bdev);
>> @@ -732,7 +733,7 @@ static int make_request(request_queue_t 
>>  #endif
>>  rcu_read_lock();
>>  for (i = 0;  i < disks; i++) {
>> - if ((rdev=conf->mirrors[i].rdev) != NULL &&
>> + if ((rdev=rcu_dereference(conf->mirrors[i].rdev)) != NULL &&
>>      !rdev->faulty) {
>>  atomic_inc(&rdev->nr_pending);
>>  if (rdev->faulty) {
>> diff -urpNa -X dontdiff linux-2.6.14-rc4/drivers/md/raid5.c linux-2.6.14-rc4_patch/drivers/md/raid5.c
>> --- linux-2.6.14-rc4/drivers/md/raid5.c 2005-10-10 18:19:19.000000000 -0700
>> +++ linux-2.6.14-rc4_patch/drivers/md/raid5.c 2005-10-11 13:27:27.000000000 -0700
>> @@ -1305,12 +1305,11 @@ static void handle_stripe(struct stripe_
>>  bi->bi_end_io = raid5_end_read_request;
>>   
>>  rcu_read_lock();
>> - rdev = conf->disks[i].rdev;
>> + rdev = rcu_dereference(conf->disks[i].rdev);
>>  if (rdev && rdev->faulty)
>>  rdev = NULL;
>>  if (rdev)
>>  atomic_inc(&rdev->nr_pending);
>> - rcu_read_unlock();
>>   
>>  if (rdev) {
>>  if (test_bit(R5_Syncio, &sh->dev[i].flags))
>> @@ -1339,6 +1338,7 @@ static void handle_stripe(struct stripe_
>>  clear_bit(R5_LOCKED, &sh->dev[i].flags);
>>  set_bit(STRIPE_HANDLE, &sh->state);
>>  }
>> + rcu_read_unlock();
>>  }
>>  }
>>  
>> @@ -1379,7 +1379,7 @@ static void unplug_slaves(mddev_t *mddev
>>  
>>  rcu_read_lock();
>>  for (i=0; i<mddev->raid_disks; i++) {
>> - mdk_rdev_t *rdev = conf->disks[i].rdev;
>> + mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
>>  if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
>>  request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
>>  
>> @@ -1424,7 +1424,7 @@ static int raid5_issue_flush(request_que
>>  
>>  rcu_read_lock();
>>  for (i=0; i<mddev->raid_disks && ret == 0; i++) {
>> - mdk_rdev_t *rdev = conf->disks[i].rdev;
>> + mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
>>  if (rdev && !rdev->faulty) {
>>  struct block_device *bdev = rdev->bdev;
>>  request_queue_t *r_queue = bdev_get_queue(bdev);
>> diff -urpNa -X dontdiff linux-2.6.14-rc4/drivers/md/raid6main.c linux-2.6.14-rc4_patch/drivers/md/raid6main.c
>> --- linux-2.6.14-rc4/drivers/md/raid6main.c 2005-10-10 18:19:19.000000000 -0700
>> +++ linux-2.6.14-rc4_patch/drivers/md/raid6main.c 2005-10-11 13:29:08.000000000 -0700
>> @@ -1464,7 +1464,7 @@ static void handle_stripe(struct stripe_
>>  bi->bi_end_io = raid6_end_read_request;
>>  
>>  rcu_read_lock();
>> - rdev = conf->disks[i].rdev;
>> + rdev = rcu_dereference(conf->disks[i].rdev);
>>  if (rdev && rdev->faulty)
>>  rdev = NULL;
>>  if (rdev)
>> @@ -1538,7 +1538,7 @@ static void unplug_slaves(mddev_t *mddev
>>  
>>  rcu_read_lock();
>>  for (i=0; i<mddev->raid_disks; i++) {
>> - mdk_rdev_t *rdev = conf->disks[i].rdev;
>> + mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
>>  if (rdev && !rdev->faulty && atomic_read(&rdev->nr_pending)) {
>>  request_queue_t *r_queue = bdev_get_queue(rdev->bdev);
>>  
>> @@ -1583,7 +1583,7 @@ static int raid6_issue_flush(request_que
>>  
>>  rcu_read_lock();
>>  for (i=0; i<mddev->raid_disks && ret == 0; i++) {
>> - mdk_rdev_t *rdev = conf->disks[i].rdev;
>> + mdk_rdev_t *rdev = rcu_dereference(conf->disks[i].rdev);
>>  if (rdev && !rdev->faulty) {
>>  struct block_device *bdev = rdev->bdev;
>>  request_queue_t *r_queue = bdev_get_queue(bdev);
