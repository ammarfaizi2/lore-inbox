Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269463AbRIDWDM>; Tue, 4 Sep 2001 18:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269421AbRIDWDE>; Tue, 4 Sep 2001 18:03:04 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:17171 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S269489AbRIDWCw>; Tue, 4 Sep 2001 18:02:52 -0400
Message-ID: <3B9548BF.CB0DE452@namesys.com>
Date: Wed, 05 Sep 2001 01:33:51 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Pavel Machek <pavel@suse.cz>, Nikita Danilov <Nikita@namesys.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: Reiserfs: how to mount without journal replay?
In-Reply-To: <20010826130858.A39@toy.ucw.cz> <15246.11218.125243.775849@gargle.gargle.HOWL> <20010830225323.A18630@atrey.karlin.mff.cuni.cz> <3B8EAD35.5695B30B@namesys.com> <20010830235005.B9330@bug.ucw.cz> <417980000.999636835@tiny>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hate to ask you this, but will the result be a stream of users mounting
-noreplay, and then asking us why things are broken (or worse, not asking....).

:-/

I think I would prefer something like:

-no_journal_replay causes mount to fail if there is a non-empty unplayed log,
and otherwise (when lacking other reason for failing) succeed.

-no_journal_replay_mount_broken_fs causes mount to succeed without replaying
even if there is a non-empty log.  If there is a non-empty log, it mounts it
readonly.

Notice how I don't assume the user will either read the man-page beyond the
names of the mount options before using the options and then deciding reiserfs
is broken, or that he will understand that the only thing replay could refer to
is the journal (you can use log if the number of letters concerns you).  I do
assume that the number of users for this option will be so small that saving
their typing is not worthwhile, and discouraging them by the amount of typing
required is just fine to do in this case anyway....:-)

Being logically correct and documented on it won't save us from the users,
always try to keep that in mind....:-)

Mounting readonly should replay the log unless -no_journal_replay is specified. 
Replaying the log is the correct thing to do for most users who don't read
reiserfs man pages before supplying options to mount (and we do value those
users).  Users who use write-protected media to hold non-empty journals on
reiserfs filesystems, well...., we should fail the mount for them, and if you
fail with an error message telling them what to do to fix things we'll put you
in for sainthood.

Hans


Chris Mason wrote:
> 
> On Thursday, August 30, 2001 11:50:05 PM +0200 Pavel Machek <pavel@suse.cz> wrote:
> 
> > ext2 is willing to mount ro even with known inconsistencies. SuSE 7.1
> > does not come with 'live filesystem' and install cd does not have
> > reiserfsck on it. Too bad. You have to install somewhere to be able to
> > run reiserfsck on suse7.1.
> 
> If your reiserfs isn't consistent, your chances of finding reiserfsck in
> the broken btree are slim to none.  A readonly mount in this case is
> unlikely to find a valid, fully intact reiserfsck executable.
> 
> The best reason I've heard for a -o noreplay option is for shared
> readonly mounts.  The patch below adds that, with a few conditions:
> 
> mount -o noreplay /dev/xxx /mnt
> 
> If no log replay is required, rw mount succeeds (ro is -o noreplay,ro is used).
> 
> Otherwise, no replay is done, mount is changed to readonly.  Later
> attempts at mount -o rw,remount /mnt will fail with -EIO.
> 
> This is lightly tested, and not intended for inclusion anywhere.  If
> there's enough interest, I'll verify and send in.
> 
> (against 2.4.10pre4)
> 
> -chris
> 
> #
> --- linux/include/linux/reiserfs_fs_sb.h        Tue Sep  4 14:37:27 2001
> +++ linux/include/linux/reiserfs_fs_sb.h        Tue Sep  4 14:39:44 2001
> @@ -387,6 +387,7 @@
>  #define REISERFS_NO_UNHASHED_RELOCATION 12
>  #define REISERFS_HASHED_RELOCATION 13
>  #define REISERFS_TEST4 14
> +#define REISERFS_NO_REPLAY 15
> 
>  #define REISERFS_TEST1 11
>  #define REISERFS_TEST2 12
> @@ -401,6 +402,7 @@
>  #define reiserfs_no_unhashed_relocation(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NO_UNHASHED_RELOCATION))
>  #define reiserfs_hashed_relocation(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_HASHED_RELOCATION))
>  #define reiserfs_test4(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_TEST4))
> +#define reiserfs_noreplay(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REISERFS_NO_REPLAY))
> 
>  #define dont_have_tails(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << NOTAIL))
>  #define replay_only(s) ((s)->u.reiserfs_sb.s_mount_opt & (1 << REPLAYONLY))
> --- linux/include/linux/reiserfs_fs.h   Tue Sep  4 14:37:27 2001
> +++ linux/include/linux/reiserfs_fs.h   Tue Sep  4 15:47:43 2001
> @@ -1723,6 +1723,7 @@
>  */
>  #define JOURNAL_BUFFER(j,n) ((j)->j_ap_blocks[((j)->j_start + (n)) % JOURNAL_BLOCK_COUNT])
> 
> +int reiserfs_replay_error(struct super_block *s) ;
>  void reiserfs_wait_on_write_block(struct super_block *s) ;
>  void reiserfs_block_writes(struct reiserfs_transaction_handle *th) ;
>  void reiserfs_allow_writes(struct super_block *s) ;
> --- linux/fs/reiserfs/journal.c Sun Sep  2 03:52:37 2001
> +++ linux/fs/reiserfs/journal.c Tue Sep  4 15:57:59 2001
> @@ -96,6 +96,7 @@
> 
>  /* state bits for the journal */
>  #define WRITERS_BLOCKED 1      /* set when new writers not allowed */
> +#define REPLAY_ERROR 2      /* set when -o noreplay forces unclean mount */
> 
>  static int do_journal_end(struct reiserfs_transaction_handle *,struct super_block *,unsigned long nblocks,int flags) ;
>  static int flush_journal_list(struct super_block *s, struct reiserfs_journal_list *jl, int flushall) ;
> @@ -106,6 +107,10 @@
>    memset(SB_JOURNAL(p_s_sb)->j_hash_table, 0, JOURNAL_HASH_SIZE * sizeof(struct reiserfs_journal_cnode *)) ;
>  }
> 
> +int reiserfs_replay_error(struct super_block *s) {
> +    return test_bit(REPLAY_ERROR, &SB_JOURNAL(s)->j_state) ;
> +}
> +
>  /*
>  ** clears BH_Dirty and sticks the buffer on the clean list.  Called because I can't allow refile_buffer to
>  ** make schedule happen after I've freed a block.  Look at remove_from_transaction and journal_mark_freed for
> @@ -1651,12 +1656,20 @@
>      brelse(d_bh) ;
>    }
> 
> -  if (continue_replay && is_read_only(p_s_sb->s_dev)) {
> -    printk("clm-2076: device is readonly, unable to replay log\n") ;
> -    return -1 ;
> -  }
> -  if (continue_replay && (p_s_sb->s_flags & MS_RDONLY)) {
> -    printk("Warning, log replay starting on readonly filesystem\n") ;
> +  if (continue_replay) {
> +    if (is_read_only(p_s_sb->s_dev)) {
> +      printk("clm-2076: device is readonly, unable to replay log\n") ;
> +      return -1 ;
> +    }
> +    if (reiserfs_noreplay(p_s_sb)) {
> +      printk("-o noreplay used to force unclean mount.  FS set to readonly\n");
> +      p_s_sb->s_flags |= MS_RDONLY ;
> +      set_bit(REPLAY_ERROR, &SB_JOURNAL(p_s_sb)->j_state) ;
> +      return 0 ;
> +    }
> +    if (p_s_sb->s_flags & MS_RDONLY) {
> +      printk("Warning, log replay starting on readonly filesystem\n") ;
> +    }
>    }
> 
>    /* ok, there are transactions that need to be replayed.  start with the first log block, find
> @@ -2022,6 +2035,12 @@
>      th->t_super = p_s_sb ; /* others will check this for the don't log flag */
>      return 0 ;
>    }
> +
> +  if (test_bit(REPLAY_ERROR, &SB_JOURNAL(p_s_sb)->j_state)) {
> +    printk("clm-2100: calling journal_begin after replay errors\n") ;
> +    BUG() ;
> +  }
> +
> 
>  relock:
>    lock_journal(p_s_sb) ;
> --- linux/fs/reiserfs/super.c   Tue Sep  4 14:37:28 2001
> +++ linux/fs/reiserfs/super.c   Tue Sep  4 15:58:02 2001
> @@ -176,6 +176,8 @@
>             set_bit (REISERFS_HASHED_RELOCATION, mount_options);
>         } else if (!strcmp (this_char, "test4")) {
>             set_bit (REISERFS_TEST4, mount_options);
> +       } else if (!strcmp (this_char, "noreplay")) {
> +           set_bit (REISERFS_NO_REPLAY, mount_options);
>         } else if (!strcmp (this_char, "nolog")) {
>             reiserfs_warning("reiserfs: nolog mount option not supported yet\n");
>         } else if (!strcmp (this_char, "replayonly")) {
> @@ -268,6 +270,14 @@
>      journal_mark_dirty(&th, s, SB_BUFFER_WITH_SB (s));
>      s->s_dirt = 0;
>    } else {
> +    /* if we are currently readonly, and were mounted with noreplay,
> +    ** we need to check if replay failed and the journal params are not
> +    ** correctly set.  If so, we cannot allow a rw mount, horrible, horrible
> +    ** things would happen
> +    */
> +    if (reiserfs_replay_error(s)) {
> +      return -EIO ;
> +    }
>      s->u.reiserfs_sb.s_mount_state = sb_state(rs) ;
>      s->s_flags &= ~MS_RDONLY ; /* now it is safe to call journal_begin */
>      journal_begin(&th, s, 10) ;
