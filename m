Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbSLVL34>; Sun, 22 Dec 2002 06:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266256AbSLVL34>; Sun, 22 Dec 2002 06:29:56 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:57832 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S265705AbSLVL3x>; Sun, 22 Dec 2002 06:29:53 -0500
Message-ID: <20021222113754.15064.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: akpm@digeo.com, ciarrocchi@linuxmail.org
Cc: linux-kernel@vger.kernel.org
Date: Sun, 22 Dec 2002 19:37:53 +0800
Subject: Re: Poor performance with 2.5.52, load and process in D state
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@digeo.com>
> Paolo Ciarrocchi wrote:
> > 
> > Hi all,
> > I booted 2.5.52 with the following parmater:
> > apm=off mem=32M (not sure about the amount, anyway I can reproduce
> > the problem for sure with 32M and 40M)
> > 
> > Then I tried the osdb (www.osdb.org) benchmark with
> > 40M of data.
> > 
> > $./bin/osdb-pg --nomulti
> > 
> > the result is that aftwer a few second running top I see the postmaster
> > process in D state and a lot if iowait.
> 
> What exactly _is_ the issue?  The machine is achieving 25% CPU utilisation
> in user code, 6-9% in system code.  It is doing a lot of I/O, and is
> getting work done.

Ok, I'm back with the results of the osdb test against 2.4.19 and 2.5.52
Both the kernel booted with apm=off mem=40M
osdb ran with 40M of data.
To summarize the results:
2.4.19 "Single User Test"	806.78 seconds	(0:13:26.78)
2.5.52 "Single User Test"	3771.85 seconds	(1:02:51.85)

Something strange is happening here.

Following the full logs of the test

"osdb"
"Invoked: ./bin/osdb-pg --nomulti --logfile /var/lib/pgsql/2.4.19-nomulti-40M.log"
                 create_tables()	0.10 seconds	return value = 0
                          load()	34.59 seconds	return value = 0
     create_idx_uniques_key_bt()	24.31 seconds	return value = 0
     create_idx_updates_key_bt()	26.53 seconds	return value = 0
     create_idx_hundred_key_bt()	22.78 seconds	return value = 0
      create_idx_tenpct_key_bt()	24.08 seconds	return value = 0
 create_idx_tenpct_key_code_bt()	6.03 seconds	return value = 0
        create_idx_tiny_key_bt()	0.33 seconds	return value = 0
      create_idx_tenpct_int_bt()	2.97 seconds	return value = 0
   create_idx_tenpct_signed_bt()	2.44 seconds	return value = 0
     create_idx_uniques_code_h()	13.95 seconds	return value = 0
   create_idx_tenpct_double_bt()	3.78 seconds	return value = 0
   create_idx_updates_decim_bt()	7.74 seconds	return value = 0
    create_idx_tenpct_float_bt()	2.61 seconds	return value = 0
     create_idx_updates_int_bt()	4.37 seconds	return value = 0
    create_idx_tenpct_decim_bt()	4.84 seconds	return value = 0
     create_idx_hundred_code_h()	7.84 seconds	return value = 0
      create_idx_tenpct_name_h()	124.83 seconds	return value = 0
     create_idx_updates_code_h()	11.82 seconds	return value = 0
      create_idx_tenpct_code_h()	11.95 seconds	return value = 0
  create_idx_updates_double_bt()	3.99 seconds	return value = 0
    create_idx_hundred_foreign()	12.27 seconds	return value = 0
              populateDataBase()	355.06 seconds	return value = 0

"Logical database size 40MB"

                      sel_1_cl()	0.24 seconds	return value = 1
                     join_3_cl()	0.10 seconds	return value = 0
                   sel_100_ncl()	0.33 seconds	return value = 100
                    table_scan()	1.81 seconds	return value = 0
                      agg_func()	16.48 seconds	return value = 100
                      agg_scal()	1.51 seconds	return value = 0
                    sel_100_cl()	1.17 seconds	return value = 100
                    join_3_ncl()	14.47 seconds	return value = 1
                 sel_10pct_ncl()	3.16 seconds	return value = 10000
             agg_simple_report()	66.67 seconds	return value = 990009900
            agg_info_retrieval()	0.26 seconds	return value = 0
               agg_create_view()	0.48 seconds	return value = 0
           agg_subtotal_report()	4.81 seconds	return value = 1000
              agg_total_report()	6.33 seconds	return value = 932849
                     join_2_cl()	0.43 seconds	return value = 0
                        join_2()	3.13 seconds	return value = 1000
       sel_variable_select_low()	1.78 seconds	return value = 0
      sel_variable_select_high()	3.25 seconds	return value = 25000
                     join_4_cl()	0.04 seconds	return value = 0
                      proj_100()	19.83 seconds	return value = 10000
                    join_4_ncl()	21.71 seconds	return value = 1
                    proj_10pct()	12.29 seconds	return value = 100000
                     sel_1_ncl()	0.37 seconds	return value = 1
                    join_2_ncl()	6.70 seconds	return value = 1
                integrity_test()	2.27 seconds	return value = 0
             drop_updates_keys()	0.30 seconds	return value = 0
                     bulk_save()	0.16 seconds	return value = 0
                   bulk_modify()	296.61 seconds	return value = 0
          upd_append_duplicate()	0.42 seconds	return value = 0
          upd_remove_duplicate()	0.00 seconds	return value = 0
                 upd_app_t_mid()	0.00 seconds	return value = 1
                 upd_mod_t_mid()	0.30 seconds	return value = 0
                 upd_del_t_mid()	0.30 seconds	return value = 0
                 upd_app_t_end()	0.03 seconds	return value = 1
                 upd_mod_t_end()	0.30 seconds	return value = 0
                 upd_del_t_end()	0.30 seconds	return value = 0
     create_idx_updates_code_h()	12.21 seconds	return value = 0
                 upd_app_t_mid()	0.07 seconds	return value = 1
                 upd_mod_t_cod()	0.03 seconds	return value = 0
                 upd_del_t_mid()	0.67 seconds	return value = 0
     create_idx_updates_int_bt()	3.63 seconds	return value = 0
                 upd_app_t_mid()	0.16 seconds	return value = 1
                 upd_mod_t_int()	0.05 seconds	return value = 0
                 upd_del_t_mid()	0.94 seconds	return value = 0
                   bulk_append()	0.44 seconds	return value = 0
                   bulk_delete()	299.05 seconds	return value = 0

"Single User Test"	806.78 seconds	(0:13:26.78)

"osdb"
"Invoked: ./bin/osdb-pg --nomulti --logfile /var/lib/pgsql/2.5.52-nomulti-40M.log"
                 create_tables()	0.06 seconds	return value = 0
                          load()	36.89 seconds	return value = 0
     create_idx_uniques_key_bt()	1043.04 seconds	return value = 0
     create_idx_updates_key_bt()	808.48 seconds	return value = 0
     create_idx_hundred_key_bt()	749.90 seconds	return value = 0
      create_idx_tenpct_key_bt()	641.84 seconds	return value = 0
 create_idx_tenpct_key_code_bt()	6.11 seconds	return value = 0
        create_idx_tiny_key_bt()	0.06 seconds	return value = 0
      create_idx_tenpct_int_bt()	3.35 seconds	return value = 0
   create_idx_tenpct_signed_bt()	3.01 seconds	return value = 0
     create_idx_uniques_code_h()	18.30 seconds	return value = 0
   create_idx_tenpct_double_bt()	4.91 seconds	return value = 0
   create_idx_updates_decim_bt()	7.18 seconds	return value = 0
    create_idx_tenpct_float_bt()	3.91 seconds	return value = 0
     create_idx_updates_int_bt()	3.93 seconds	return value = 0
    create_idx_tenpct_decim_bt()	6.39 seconds	return value = 0
     create_idx_hundred_code_h()	8.03 seconds	return value = 0
      create_idx_tenpct_name_h()	130.66 seconds	return value = 0
     create_idx_updates_code_h()	13.18 seconds	return value = 0
      create_idx_tenpct_code_h()	12.96 seconds	return value = 0
  create_idx_updates_double_bt()	4.45 seconds	return value = 0
    create_idx_hundred_foreign()	11.29 seconds	return value = 0
              populateDataBase()	3518.83 seconds	return value = 0

"Logical database size 40MB"

                      sel_1_cl()	0.28 seconds	return value = 1
                     join_3_cl()	0.11 seconds	return value = 0
                   sel_100_ncl()	2.25 seconds	return value = 100
                    table_scan()	1.80 seconds	return value = 0
                      agg_func()	15.74 seconds	return value = 100
                      agg_scal()	1.66 seconds	return value = 0
                    sel_100_cl()	1.79 seconds	return value = 100
                    join_3_ncl()	23.20 seconds	return value = 1
                 sel_10pct_ncl()	3.57 seconds	return value = 10000
             agg_simple_report()	69.20 seconds	return value = 990009900
            agg_info_retrieval()	0.44 seconds	return value = 0
               agg_create_view()	0.39 seconds	return value = 0
           agg_subtotal_report()	10.68 seconds	return value = 1000
              agg_total_report()	9.65 seconds	return value = 932849
                     join_2_cl()	0.11 seconds	return value = 0
                        join_2()	3.57 seconds	return value = 1000
       sel_variable_select_low()	1.55 seconds	return value = 0
      sel_variable_select_high()	3.81 seconds	return value = 25000
                     join_4_cl()	0.07 seconds	return value = 0
                      proj_100()	21.08 seconds	return value = 10000
                    join_4_ncl()	36.16 seconds	return value = 1
                    proj_10pct()	13.07 seconds	return value = 100000
                     sel_1_ncl()	0.18 seconds	return value = 1
                    join_2_ncl()	12.18 seconds	return value = 1
                integrity_test()	9.07 seconds	return value = 0
             drop_updates_keys()	0.63 seconds	return value = 0
                     bulk_save()	0.69 seconds	return value = 0
                   bulk_modify()	1923.65 seconds	return value = 0
          upd_append_duplicate()	0.30 seconds	return value = 0
          upd_remove_duplicate()	0.09 seconds	return value = 0
                 upd_app_t_mid()	0.03 seconds	return value = 1
                 upd_mod_t_mid()	2.04 seconds	return value = 0
                 upd_del_t_mid()	1.67 seconds	return value = 0
                 upd_app_t_end()	0.08 seconds	return value = 1
                 upd_mod_t_end()	1.67 seconds	return value = 0
                 upd_del_t_end()	1.78 seconds	return value = 0
     create_idx_updates_code_h()	13.74 seconds	return value = 0
                 upd_app_t_mid()	0.12 seconds	return value = 1
                 upd_mod_t_cod()	0.03 seconds	return value = 0
                 upd_del_t_mid()	2.29 seconds	return value = 0
     create_idx_updates_int_bt()	4.06 seconds	return value = 0
                 upd_app_t_mid()	0.15 seconds	return value = 1
                 upd_mod_t_int()	0.01 seconds	return value = 0
                 upd_del_t_mid()	2.13 seconds	return value = 0
                   bulk_append()	2.59 seconds	return value = 0
                   bulk_delete()	1570.86 seconds	return value = 0

"Single User Test"	3771.85 seconds	(1:02:51.85)




-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
